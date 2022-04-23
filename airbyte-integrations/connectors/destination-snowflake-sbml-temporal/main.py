#
# Copyright (c) 2021 Airbyte, Inc., all rights reserved.
#


import sys

from destination_snowflake_sbml_temporal import DestinationSnowflakeSbmlTemporal

if __name__ == "__main__":
    import sys

    temp_args = ['write', '--config', 'config.json', '--catalog', 'catalog.json']
    DestinationSnowflakeSbmlTemporal().run(temp_args)
    # DestinationSnowflakeSbmlTemporal().run(sys.argv[1:])
