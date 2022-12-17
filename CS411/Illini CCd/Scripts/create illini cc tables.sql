CREATE TABLE Payment_Processors(
    processor_id INT PRIMARY KEY,
    processor_name VARCHAR(255) NOT NULL,
    domestic_accept INT,
    international_accept INT,
    total_cards_us INT,
    total_vol_us INT,
    num_trans INT,
    avg_proc_fee REAL
);

CREATE TABLE Credit_Cards(
    card_id INT PRIMARY KEY,
    card_name VARCHAR(255) NOT NULL,
    processor_id INT,
    bank VARCHAR(255),
    annual_fee INT,
    credit_limit REAL,
    signup_bonus REAL,
    APR_min REAL,
    APR_max REAL,
    min_rec_credit INT,
    image_url VARCHAR(10000),
    signup_link VARCHAR(255),
    foreign_trans_fee REAL,
    reward_type CHAR(1),
    CONSTRAINT cc_fk_processor_id
        FOREIGN KEY (processor_id) 
        REFERENCES Payment_Processors(processor_id) 
        ON DELETE SET NULL
);


CREATE TABLE Preferred_Vendors(
    vend_id INT PRIMARY KEY,
    vend_name VARCHAR(255) NOT NULL,
    vend_type VARCHAR(255),
    vend_website VARCHAR(255)
);

CREATE TABLE Offers(
    card_id INT,
    vend_id INT,
    CONSTRAINT offer_fk_card_id
        FOREIGN KEY (card_id) 
        REFERENCES Credit_Cards(card_id) 
        ON DELETE CASCADE,
    CONSTRAINT offer_fk_vend_id
        FOREIGN KEY (vend_id) 
        REFERENCES Preferred_Vendors(vend_id) 
        ON DELETE CASCADE
);

CREATE TABLE Categories(
    cat_id INT PRIMARY KEY,
    card_id INT,
    cat_name VARCHAR(255) NOT NULL,
    cat_desc VARCHAR(255) NOT NULL,
    reward REAL,
    CONSTRAINT cat_fk_card_id 
        FOREIGN KEY (card_id)
        REFERENCES Credit_Cards(card_id) 
        ON DELETE CASCADE
);

CREATE TABLE Card_Ratings(
    rating_id INT PRIMARY KEY,
    card_id INT NOT NULL,
    website_name VARCHAR(255),
    rating REAL,
    CONSTRAINT rate_fk_card_id 
        FOREIGN KEY (card_id) 
        REFERENCES Credit_Cards(card_id) 
        ON DELETE CASCADE
);

CREATE TABLE Click_Logs(
    card_id INT,
    date_time DATETIME, 
    ip_addr VARCHAR(255),
    PRIMARY KEY (date_time, ip_addr),
    CONSTRAINT click_fk_card_id
        FOREIGN KEY (card_id)
        REFERENCES Credit_Cards(card_id) 
        ON DELETE CASCADE
);
