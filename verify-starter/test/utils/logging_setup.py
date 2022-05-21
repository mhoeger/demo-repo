import logging


def setup_logger(name: str):
    logger = logging.getLogger(name)
    # logger.setLevel(settings.log_level)

    return logger