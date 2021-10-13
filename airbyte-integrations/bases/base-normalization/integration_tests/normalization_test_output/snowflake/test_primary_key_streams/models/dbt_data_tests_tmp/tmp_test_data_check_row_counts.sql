with table_row_counts as (
    select distinct count(*) as row_count, 10 as expected_count
    from {{ source('TEST_NORMALIZATION', '_AIRBYTE_RAW_EXCHANGE_RATE') }}
union all
    select distinct count(*) as row_count, 10 as expected_count
    from {{ ref('EXCHANGE_RATE') }}

union all

    select distinct count(*) as row_count, 10 as expected_count
    from {{ source('TEST_NORMALIZATION', '_AIRBYTE_RAW_DEDUP_EXCHANGE_RATE') }}
union all
    select distinct count(*) as row_count, 10 as expected_count
    from {{ ref('DEDUP_EXCHANGE_RATE_SCD') }}
union all
    select distinct count(*) as row_count, 5 as expected_count
    from {{ ref('DEDUP_EXCHANGE_RATE') }}

union all

    select distinct count(*) as row_count, 8 as expected_count
    from {{ source('TEST_NORMALIZATION', '_AIRBYTE_RAW_DEDUP_CDC_EXCLUDED') }}
union all
    select distinct count(*) as row_count, 8 as expected_count
    from {{ ref('DEDUP_CDC_EXCLUDED_SCD') }}
union all
    select distinct count(*) as row_count, 4 as expected_count
    from {{ ref('DEDUP_CDC_EXCLUDED') }}

union all

    select distinct count(*) as row_count, 8 as expected_count
    from {{ source('TEST_NORMALIZATION', '_AIRBYTE_RAW_POS_DEDUP_CDCX') }}
union all
    select distinct count(*) as row_count, 8 as expected_count
    from {{ ref('POS_DEDUP_CDCX_SCD') }}
union all
    select distinct count(*) as row_count, 3 as expected_count
    from {{ ref('POS_DEDUP_CDCX') }}

union all

    select distinct count(*) as row_count, 2 as expected_count
    from {{ source('TEST_NORMALIZATION', '_AIRBYTE_RAW_NESTED_STREAM_WITH_COMPLEX_COLUMNS_RESULTING_INTO_LONG_NAMES') }}
union all
    select distinct count(*) as row_count, 2 as expected_count
    from {{ ref('NESTED_STREAM_WITH_COMPLEX_COLUMNS_RESULTING_INTO_LONG_NAMES') }}
union all
    select distinct count(*) as row_count, 2 as expected_count
    from {{ ref('NESTED_STREAM_WITH_COMPLEX_COLUMNS_RESULTING_INTO_LONG_NAMES_PARTITION') }}
union all
    select count(distinct currency) as row_count, 1 as expected_count
    from {{ ref('NESTED_STREAM_WITH_COMPLEX_COLUMNS_RESULTING_INTO_LONG_NAMES_PARTITION_DATA') }}
-- union all
--    select count(distinct id) as row_count, 3 as expected_count
--    from {{ ref('NESTED_STREAM_WITH_COMPLEX_COLUMNS_RESULTING_INTO_LONG_NAMES_PARTITION_DOUBLE_ARRAY_DATA') }}
)
select *
from table_row_counts
where row_count != expected_count
