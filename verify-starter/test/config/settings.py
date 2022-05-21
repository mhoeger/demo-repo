import logging
import os

from dataclasses import dataclass, field

from test.config.constants import ENV_NAME

ENV = os.environ[ENV_NAME]
