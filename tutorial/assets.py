
from dagster import asset

@asset
def call():
    return "Hello, World! I'm an asset!"