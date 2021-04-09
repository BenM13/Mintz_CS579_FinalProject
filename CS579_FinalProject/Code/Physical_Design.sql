-- Ben Mintz
-- MET CS579
-- Project Physical Design: SKi Resort Rental Shop

-- NOTE: this script was written with MySQL-specific syntax

CREATE TABLE customer (
	customer_id INTEGER PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    email VARCHAR (50) NOT NULL,
    phone VARCHAR(12),
    street VARCHAR(50) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state VARCHAR(2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL
);

CREATE TABLE skier (
	skier_id INTEGER PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    dob DATE,
    height INTEGER,
    weight INTEGER,
    ability_level INTEGER
);

CREATE TABLE agreement (
	agreement_id INTEGER PRIMARY KEY,
    time_of_rental DATE NOT NULL,
    due_by DATE NOT NULL,
    customer_id INTEGER NOT NULL,
    amount_due DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE INDEX time_of_rental_index ON agreement(time_of_rental);
CREATE INDEX due_by_index ON agreement(due_by);

CREATE TABLE supplier (
	supplier_id INTEGER PRIMARY KEY,
    supplier_name VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    country VARCHAR(20) NOT NULL
);

CREATE TABLE inventory (
	item_no INTEGER PRIMARY KEY,
    item_type VARCHAR(12),
    supplier_id INTEGER,
    size VARCHAR(5),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

CREATE TABLE skier_item (
	agreement INTEGER,
    skier INTEGER,
    item_used INTEGER,
    item_status VARCHAR(8) DEFAULT 'In Use',
    PRIMARY KEY (agreement, skier, item_used),
    FOREIGN KEY (agreement) REFERENCES agreement(agreement_id),
    FOREIGN KEY (skier) REFERENCES skier(skier_id),
    FOREIGN KEY (item_used) REFERENCES inventory(item_no)
);

CREATE INDEX status_index ON skier_item(item_status);