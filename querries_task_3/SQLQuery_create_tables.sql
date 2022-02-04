CREATE TABLE sender (
    cust_id varchar(4) PRIMARY KEY,
    isPerson BIT,
    name varchar(15),
    surname varchar(15),
    pesel varchar(11),
    nip varchar(10),
    phoneNo varchar(9),
    zip_code char(10),
    city varchar(50),
    country varchar(50),
    street varchar(50),
    street_no int,
    flat_no int,
    comments varchar(255),
    CONSTRAINT check_custId_se
        CHECK(cust_id LIKE 'S-[0-9][0-9]'),
    CONSTRAINT check_pesel_se
        CHECK (pesel NOT LIKE '%[^0-9]%'),
    CONSTRAINT check_nip_se
        CHECK (nip NOT LIKE '%[^0-9]%'),
    CONSTRAINT check_phone_se
        CHECK (phoneNo NOT LIKE '%[^0-9]%'),
    CONSTRAINT check_zip_se
        CHECK (zip_code LIKE '[0-9][0-9]-[0-9][0-9][0-9]') 
);




CREATE TABLE receiver (
    cust_id char(4) PRIMARY KEY NOT NULL,
    isPerson BIT,
    name varchar(15),
    surname varchar(15),
    pesel varchar(11),
    nip varchar(10),
    phoneNo varchar(9),
    zip_code char(10),
    city varchar(50),
    country varchar(50),
    street varchar(50),
    street_no int,
    flat_no int,
    CONSTRAINT check_custId_re
        CHECK(cust_id LIKE 'R-[0-9][0-9]'),
    CONSTRAINT check_pesel_re
        CHECK (pesel NOT LIKE '%[^0-9]%'),
    CONSTRAINT check_nip_re
        CHECK (nip NOT LIKE '%[^0-9]%'),
    CONSTRAINT check_phone_re
        CHECK (phoneNo NOT LIKE '%[^0-9]%'),
    CONSTRAINT check_zip_re
        CHECK (zip_code LIKE '[0-9][0-9]-[0-9][0-9][0-9]') 
);    




CREATE TABLE vehicle(
    vin varchar(20) PRIMARY KEY NOT NULL,
    brand varchar(255),
    model varchar(255),
    type varchar(255),
    capacity float,
    weight float,
    num_of_packages int,
);



CREATE TABLE driver(
    driver_id varchar(4) PRIMARY KEY NOT NULL,
    qualification varchar(255),
    age int,
    driv_lic_no varchar(255),
    isWorking BIT,
    isAvailable BIT,
    firstname varchar(255),
    surname varchar(255),
    pesel varchar(11) UNIQUE,
    contact varchar(255),

    CONSTRAINT check_driverid
        CHECK(driver_id LIKE 'D-[0-9][0-9]'),
    CONSTRAINT check_driv_lic_no
        CHECK(driv_lic_no LIKE '[0-9][0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]'),
    CONSTRAINT check_pesel_dr
        CHECK (pesel NOT LIKE '%[^0-9]%')
);




CREATE TABLE courier(
courier_id varchar(4) REFERENCES driver PRIMARY KEY NOT NULL,
sector_of_work char(5),
num_of_order int,
CONSTRAINT check_sector
    CHECK(sector_of_work LIKE '[A-Z].[a-z].[0-9]'),

);





CREATE TABLE intermediate_station(
    station_id varchar(4) PRIMARY KEY NOT NULL,
    city varchar(255),
    street varchar(255),
    street_no int,
    zip_code varchar(10),
    num_of_packages int,
    num_of_employees int,

    CONSTRAINT check_zip_is
        CHECK (zip_code LIKE '[0-9][0-9]-[0-9][0-9][0-9]'),
    CONSTRAINT check_custId_pa
        CHECK(station_id LIKE 'I-[0-9][0-9]') 

);


CREATE TABLE employee(
    employee_id varchar(4) PRIMARY KEY NOT NULL,
    wage float,
    add_infotmation varchar(255),
    station_id varchar(4) REFERENCES intermediate_station
    ON DELETE SET NULL
);

CREATE TABLE shipment (
    shipment_id char(5) PRIMARY KEY NOT NULL,
    locationX varchar(255), 
    locationY varchar(255),
    isPickedUp BIT,
    vin varchar(20) REFERENCES vehicle,
    station_id varchar(4) REFERENCES intermediate_station
    ON DELETE SET NULL,
    courier_id varchar(4) NOT NULL REFERENCES courier,
    CONSTRAINT shipment_id_check
        CHECK(shipment_id LIKE 'SH-[0-9][0-9]'),
    CONSTRAINT locationX_check_sh
        CHECK(locationX LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]'),
    CONSTRAINT locationY_check_sh
        CHECK(locationY LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]'),
    

);



CREATE TABLE package (
    package_id char(4) PRIMARY KEY NOT NULL,
    weight float,
    price float,
    status char(255),
    volume float,
    isPaid BIT,
    special_features char(255),
    date_of_dispatch date,
    date_of_receiv date,
    send_id varchar(4) NOT NULL REFERENCES sender
    ON DELETE CASCADE,
    rece_id char(4) NOT NULL REFERENCES receiver
    ON DELETE CASCADE,
    ship_id char(5) NOT NULL REFERENCES shipment
    ON DELETE CASCADE,
    CONSTRAINT check_package_id
        CHECK(package_id LIKE 'P-[0-9][0-9]')
);


CREATE TABLE transport(
    transport_id varchar(4) PRIMARY KEY,
    locationX varchar(255), 
    locationY varchar(255),
    isOnRoad BIT,
    vin varchar(20) REFERENCES vehicle,
    station_to varchar(4)  REFERENCES intermediate_station
    ON DELETE NO ACTION,
    station_from varchar(4) REFERENCES intermediate_station
    ON DELETE NO ACTION,
    driver_id varchar(4) REFERENCES driver,
    
    CONSTRAINT check_transport_id
        CHECK(transport_id LIKE 'T-[0-9][0-9]'),
    CONSTRAINT locationX_check_t
        CHECK(locationX LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]'),
    CONSTRAINT locationY_check_t
        CHECK(locationY LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]')

);



CREATE TABLE delivery(
    delivery_id varchar(5) PRIMARY KEY,
    locationX varchar(255), 
    locationY varchar(255),
    isDelivered BIT,
    num_of_attempt int,
    toLocker BIT DEFAULT 0,
    station_id varchar(4) REFERENCES intermediate_station
        ON DELETE NO ACTION,
    driver_id varchar(4) REFERENCES courier,
    CONSTRAINT check_delivery_id
        CHECK(delivery_id LIKE 'DE-[0-9][0-9]'),
    CONSTRAINT locationX_check_d
        CHECK(locationX LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]'),
    CONSTRAINT locationY_check_d
        CHECK(locationY LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]')

);



CREATE TABLE transportation(
    transport_id varchar(4) NOT NULL REFERENCES transport,
    package_id char(4) NOT NULL REFERENCES package
    ON DELETE CASCADE,
    PRIMARY KEY (transport_id,package_id)
);



CREATE TABLE end_road(
    delivery_id varchar(5) NOT NULL REFERENCES delivery,
    package_id char(4) NOT NULL REFERENCES package
    ON DELETE CASCADE,
    PRIMARY KEY (delivery_id,package_id)
);


CREATE TABLE parcel_locker(
    locker_id varchar(5) PRIMARY KEY NOT NULL,
    locationX varchar(255), 
    locationY varchar(255),
    capacity int,
    num_of_packages int,

    CONSTRAINT check_locker_id
        CHECK(locker_id LIKE 'PL-[0-9][0-9]'),
    CONSTRAINT locationX_check_pl
        CHECK(locationX LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]'),
    CONSTRAINT locationY_check_pl                                              
        CHECK(locationY LIKE '[0-9][0-9].[0-9][0-9][0-9][0-9][0-9][A-Z]')
);

 
CREATE TABLE stay_in_locker(
    package_id char(4) REFERENCES package
    ON DELETE CASCADE,
    locker_id varchar(5) REFERENCES parcel_locker,
    PRIMARY KEY (package_id,locker_id)
);


CREATE TABLE to_locker(
    locker_id varchar(5) REFERENCES parcel_locker,
    delivery_id varchar(5) REFERENCES delivery,
    PRIMARY KEY(locker_id,delivery_id)
);


CREATE TABLE load (
    delivery_id varchar(5) REFERENCES delivery,
    vin varchar(20) REFERENCES vehicle,
    PRIMARY KEY(delivery_id,vin)
);
