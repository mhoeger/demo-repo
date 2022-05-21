from my_project.utils.logging_setup import setup_logger

# you can delete this file.
def test_true():
    # pylint: disable=comparison-with-itself
    setup_logger("hello")
    assert True is True
