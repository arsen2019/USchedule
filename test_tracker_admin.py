import unittest

from fastapi import HTTPException

from api_v1.tracker.schemas import DayRecord
from api_v1.tracker.views import verify_admin_token
from core.config import settings


class TrackerAdminAuthorizationTests(unittest.TestCase):
    def setUp(self):
        self.original_token = settings.tracker_admin_token

    def tearDown(self):
        settings.tracker_admin_token = self.original_token

    def test_missing_configuration_returns_503(self):
        settings.tracker_admin_token = None
        with self.assertRaises(HTTPException) as raised:
            verify_admin_token("anything")
        self.assertEqual(raised.exception.status_code, 503)

    def test_invalid_token_returns_401(self):
        settings.tracker_admin_token = "correct-secret"
        with self.assertRaises(HTTPException) as raised:
            verify_admin_token("wrong-secret")
        self.assertEqual(raised.exception.status_code, 401)

    def test_missing_token_returns_401(self):
        settings.tracker_admin_token = "correct-secret"
        with self.assertRaises(HTTPException) as raised:
            verify_admin_token("")
        self.assertEqual(raised.exception.status_code, 401)

    def test_valid_token_is_accepted(self):
        settings.tracker_admin_token = "correct-secret"
        self.assertIsNone(verify_admin_token("correct-secret"))


class TrackerAdminSchemaTests(unittest.TestCase):
    def test_null_measurements_are_preserved(self):
        record = DayRecord.model_validate({
            "day": "2026-07-21",
            "values": {"09:00": 6.1, "14:00": None, "19:00": 7.2, "22:00": None},
        })
        self.assertIsNone(record.values.by_slot()["14:00"])


if __name__ == "__main__":
    unittest.main()
