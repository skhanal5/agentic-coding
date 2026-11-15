#!/usr/bin/env python3
"""Check that every skill in skills/ follows the repo rules.

Rules:
- Each skill folder has a SKILL.md with `name` and `description` frontmatter.
- The `name` matches the folder name.
- The description is not empty and is at most 1024 characters.
- SKILL.md is at most MAX_LINES lines.
- Each `references/...` path named in SKILL.md exists.
- evals/triggers.json has at least MIN_EACH should-trigger and should-not-trigger prompts.
"""

import json
import re
import sys
from pathlib import Path

MAX_LINES = 150
MAX_DESCRIPTION = 1024
MIN_EACH = 5

SKILLS_DIR = Path(__file__).resolve().parent.parent / "skills"


def parse_frontmatter(text: str) -> dict:
    match = re.match(r"^---\n(.*?)\n---\n", text, re.DOTALL)
    if not match:
        return {}
    fields = {}
    for line in match.group(1).splitlines():
        key, sep, value = line.partition(":")
        if sep:
            fields[key.strip()] = value.strip()
    return fields


def check_skill(folder: Path) -> list[str]:
    errors = []
    skill_file = folder / "SKILL.md"
    if not skill_file.is_file():
        return [f"{folder.name}: SKILL.md is missing"]

    text = skill_file.read_text()
    fields = parse_frontmatter(text)

    if fields.get("name") != folder.name:
        errors.append(f"{folder.name}: name is {fields.get('name')!r}, expected {folder.name!r}")

    description = fields.get("description", "")
    if not description:
        errors.append(f"{folder.name}: description is missing")
    elif len(description) > MAX_DESCRIPTION:
        errors.append(f"{folder.name}: description has {len(description)} characters, max is {MAX_DESCRIPTION}")

    line_count = len(text.splitlines())
    if line_count > MAX_LINES:
        errors.append(f"{folder.name}: SKILL.md has {line_count} lines, max is {MAX_LINES}")

    for ref in sorted(set(re.findall(r"references/[\w./-]+\.md", text))):
        if not (folder / ref).is_file():
            errors.append(f"{folder.name}: {ref} is named in SKILL.md but does not exist")

    triggers_file = folder / "evals" / "triggers.json"
    if not triggers_file.is_file():
        errors.append(f"{folder.name}: evals/triggers.json is missing")
    else:
        try:
            items = json.loads(triggers_file.read_text())
            positive = sum(1 for item in items if item["should_trigger"])
            negative = sum(1 for item in items if not item["should_trigger"])
        except (ValueError, KeyError, TypeError) as error:
            errors.append(f"{folder.name}: evals/triggers.json is not valid ({error})")
        else:
            if positive < MIN_EACH or negative < MIN_EACH:
                errors.append(
                    f"{folder.name}: evals/triggers.json has {positive} should-trigger and "
                    f"{negative} should-not-trigger prompts, need at least {MIN_EACH} of each"
                )

    return errors


def main() -> int:
    folders = sorted(path for path in SKILLS_DIR.iterdir() if path.is_dir())
    if not folders:
        print("No skills found.")
        return 1

    errors = [error for folder in folders for error in check_skill(folder)]
    for error in errors:
        print(error)
    print(f"Checked {len(folders)} skills. {len(errors)} problems.")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
