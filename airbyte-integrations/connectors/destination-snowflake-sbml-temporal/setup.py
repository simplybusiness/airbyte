#
# Copyright (c) 2021 Airbyte, Inc., all rights reserved.
#


from setuptools import find_packages, setup

MAIN_REQUIREMENTS = [
    "airbyte-cdk",
    'cmake',
    "sbml @ https://bnw-registry.simplybusiness.io/repository/sb-dna-pypi/packages/sbml/0.12.82+python38.upgrade1/sbml-0.12.82+python38.upgrade1-py3-none-any.whl"
]

TEST_REQUIREMENTS = [
    "pytest~=6.1"
]

setup(
    name="destination_snowflake_sbml_temporal",
    description="Destination implementation for Snowflake Sbml Temporal.",
    author="Airbyte",
    author_email="contact@airbyte.io",
    packages=find_packages(),
    install_requires=MAIN_REQUIREMENTS,
    package_data={"": ["*.json"]},
    extras_require={
        "tests": TEST_REQUIREMENTS,
    },
)
