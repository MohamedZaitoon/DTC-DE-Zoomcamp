if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test



@transformer
def transform(data, *args, **kwargs):
    # Rename columns in Camel Case to Snake Case
    data.columns = (data.columns
                .str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True)
                .str.lower()
             )

    # Remove rows where the passenger count is equal to 0 and the trip distance is equal to 0.
    data = data[(data['passenger_count'] != 0)]
    data = data[(data['trip_distance'] != 0)]

    # Create a new column lpep_pickup_date by converting lpep_pickup_datetime to a date.
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    return data


@test
def test_output(output, *args) -> None:
    assert output['vendor_id'].isin([1,2]).all(), 'Vendor ID = 1 or 2 is not exist'
    assert (output['passenger_count'] > 0).all() , 'Zero values in passenger count'
    assert (output['trip_distance'] > 0).all(), 'Zero values in trip distance'

