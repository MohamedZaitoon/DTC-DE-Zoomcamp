import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    base_url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/'
    

    df_list = [] 
    table_name_list = []
    for month in range(1,13):
        table_name_list.append(f'green_tripdata_2022-{str(month).rjust(2,"0")}.parquet')
        url = f'{base_url}{table_name_list[-1]}'
        df_temp =  pd.read_parquet(url)

        df_list.append(df_temp)

    df = pd.concat(df_list)
    

    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
