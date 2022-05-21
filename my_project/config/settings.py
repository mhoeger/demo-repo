import logging
import os

from dataclasses import dataclass, field

from my_project.config.constants import ENV_NAME

ENV = os.environ[ENV_NAME]
