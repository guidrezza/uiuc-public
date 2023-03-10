INSERT INTO Payment_Processors (
    processor_id,
    processor_name,
    domestic_accept,
    international_accept,
    total_cards_us,
    total_vol_us,
    num_trans,
    avg_proc_fee
)
VALUES
    (
        10000000,
        "Visa",
        10700000,
        46000000,
        369000000,
        5093,
        255400,
        0.0229
    ),
    (
        10000001,
        "American Express",
        10600000,
        44000000,
        56400000,
        1103,
        8300,
        0.02325
    ),
    (
        10000002,
        "Mastercard",
        10700000,
        37000000,
        319000000,
        2271,
        90200,
        0.0234
    ),
    (
        10000003,
        "Discover",
        10600000,
        48000000,
        57000000,
        193,
        2800,
        0.0243
    );