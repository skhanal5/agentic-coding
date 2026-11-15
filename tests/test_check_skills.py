import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "scripts"))

import check_skills

GOOD_TRIGGERS = [{"query": f"q{i}", "should_trigger": i < 5} for i in range(10)]


def write_skill(root, name, frontmatter_name=None, description="Use when needed.", body="", triggers=GOOD_TRIGGERS):
    folder = root / name
    (folder / "evals").mkdir(parents=True)
    fm_name = name if frontmatter_name is None else frontmatter_name
    (folder / "SKILL.md").write_text(f"---\nname: {fm_name}\ndescription: {description}\n---\n{body}")
    if triggers is not None:
        (folder / "evals" / "triggers.json").write_text(json.dumps(triggers))
    return folder


class CheckSkillTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)

    def errors_for(self, **kwargs):
        folder = write_skill(self.root, "demo", **kwargs)
        return check_skills.check_skill(folder)

    def test_valid_skill_has_no_errors(self):
        self.assertEqual(self.errors_for(), [])

    def test_name_must_match_folder(self):
        errors = self.errors_for(frontmatter_name="other")
        self.assertTrue(any("name is 'other'" in e for e in errors))

    def test_empty_description_is_an_error(self):
        errors = self.errors_for(description="")
        self.assertTrue(any("description is missing" in e for e in errors))

    def test_long_description_is_an_error(self):
        errors = self.errors_for(description="x" * (check_skills.MAX_DESCRIPTION + 1))
        self.assertTrue(any("description has" in e for e in errors))

    def test_long_skill_file_is_an_error(self):
        errors = self.errors_for(body="line\n" * check_skills.MAX_LINES)
        self.assertTrue(any("SKILL.md has" in e for e in errors))

    def test_missing_reference_is_an_error(self):
        errors = self.errors_for(body="Read references/missing.md\n")
        self.assertTrue(any("references/missing.md" in e for e in errors))

    def test_existing_reference_is_ok(self):
        folder = write_skill(self.root, "demo", body="Read references/real.md\n")
        (folder / "references").mkdir()
        (folder / "references" / "real.md").write_text("x")
        self.assertEqual(check_skills.check_skill(folder), [])

    def test_missing_triggers_file_is_an_error(self):
        errors = self.errors_for(triggers=None)
        self.assertTrue(any("triggers.json is missing" in e for e in errors))

    def test_too_few_negative_prompts_is_an_error(self):
        triggers = [{"query": f"q{i}", "should_trigger": True} for i in range(10)]
        errors = self.errors_for(triggers=triggers)
        self.assertTrue(any("10 should-trigger and 0 should-not-trigger" in e for e in errors))

    def test_invalid_triggers_json_is_an_error(self):
        errors = self.errors_for(triggers=[{"query": "no flag"}])
        self.assertTrue(any("not valid" in e for e in errors))

    def test_missing_skill_file_is_an_error(self):
        folder = self.root / "empty"
        folder.mkdir()
        self.assertEqual(check_skills.check_skill(folder), ["empty: SKILL.md is missing"])


if __name__ == "__main__":
    unittest.main()
