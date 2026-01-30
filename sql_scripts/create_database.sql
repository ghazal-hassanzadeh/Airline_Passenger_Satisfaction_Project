USE airline_passenger_satisfaction;

CREATE TABLE IF NOT EXISTS `genders` (
	`gender_id` INTEGER NOT NULL UNIQUE,
	`gender` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`gender_id`)
);


CREATE TABLE IF NOT EXISTS `travel_types` (
	`travel_type_id` INTEGER NOT NULL UNIQUE,
	`type_of_travel` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`travel_type_id`)
);


CREATE TABLE IF NOT EXISTS `customer_types` (
	`customer_type_id` INTEGER NOT NULL UNIQUE,
	`customer_type` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`customer_type_id`)
);


CREATE TABLE IF NOT EXISTS `satisfactions` (
	`satisfaction_id` INTEGER NOT NULL UNIQUE,
	`satisfaction` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`satisfaction_id`)
);


CREATE TABLE IF NOT EXISTS `classes` (
	`class_id` INTEGER NOT NULL UNIQUE,
	`class` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`class_id`)
);


CREATE TABLE IF NOT EXISTS `flights` (
	`flight_id` INTEGER NOT NULL UNIQUE,
	`flight_distance` INTEGER NOT NULL,
	PRIMARY KEY(`flight_id`)
);


CREATE TABLE IF NOT EXISTS `flights_classes` (
	`flight_class_id` INTEGER NOT NULL UNIQUE,
	`flight_id` INTEGER NOT NULL,
	`class_id` INTEGER NOT NULL,
	PRIMARY KEY(`flight_class_id`)
);


CREATE TABLE IF NOT EXISTS `passengers` (
	`passenger_id` INTEGER NOT NULL UNIQUE,
	`age` INTEGER NOT NULL,
	`flight_id` INTEGER NOT NULL,
	`gender_id` INTEGER NOT NULL,
	`travel_type_id` INTEGER NOT NULL,
	`satisfaction_id` INTEGER NOT NULL,
	`customer_type_id` INTEGER NOT NULL,
	PRIMARY KEY(`passenger_id`)
);


CREATE TABLE IF NOT EXISTS `surveys` (
	`id` INTEGER NOT NULL UNIQUE,
	`passenger_id` INTEGER NOT NULL,
	`inflight_wifi_service` INTEGER NOT NULL,
	`departure_arrival_time_convenient` INTEGER NOT NULL,
	`ease_of_online_booking` INTEGER NOT NULL,
	`gate_location` INTEGER NOT NULL,
	`food_and_drink` INTEGER NOT NULL,
	`online_boarding` INTEGER NOT NULL,
	`seat_comfort` INTEGER NOT NULL,
	`inflight_entertainment` INTEGER NOT NULL,
	`on_board_service` INTEGER NOT NULL,
	`leg_room_service` INTEGER NOT NULL,
	`baggage_handling` INTEGER NOT NULL,
	`checkin_service` INTEGER NOT NULL,
	`inflight_service` INTEGER NOT NULL,
	`cleanliness` INTEGER NOT NULL,
	`departure_delay_in_minutes` INTEGER,
	`arrival_delay_in_minutes` INTEGER,
	PRIMARY KEY(`id`)
);


ALTER TABLE `surveys`
ADD FOREIGN KEY(`passenger_id`) REFERENCES `passengers`(`passenger_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `flights_classes`
ADD FOREIGN KEY(`flight_id`) REFERENCES `flights`(`flight_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `flights_classes`
ADD FOREIGN KEY(`class_id`) REFERENCES `classes`(`class_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `passengers`
ADD FOREIGN KEY(`gender_id`) REFERENCES `genders`(`gender_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `passengers`
ADD FOREIGN KEY(`travel_type_id`) REFERENCES `travel_types`(`travel_type_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `passengers`
ADD FOREIGN KEY(`customer_type_id`) REFERENCES `customer_types`(`customer_type_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `passengers`
ADD FOREIGN KEY(`satisfaction_id`) REFERENCES `satisfactions`(`satisfaction_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `passengers`
ADD FOREIGN KEY(`flight_id`) REFERENCES `flights`(`flight_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;

SHOW TABLES;

SELECT COUNT(*) FROM genders;
SELECT * FROM genders;

SELECT COUNT(*) FROM travel_types;
SELECT * FROM travel_types;

SELECT COUNT(*) FROM customer_types;
SELECT * FROM customer_types;

SELECT COUNT(*) FROM satisfactions;
SELECT * FROM satisfactions;

SELECT COUNT(*) FROM classes;
SELECT * FROM classes;

SELECT COUNT(*) FROM flights;
SELECT * FROM flights LIMIT 5;


# Due to the absence of explicit class availability per flight, all flights were assumed to offer all classes.
SELECT COUNT(*) FROM flights_classes;
SELECT * 
FROM flights_classes
LIMIT 10;

#Verify FK -> Flights
SELECT COUNT(*) AS bad_flight_fk
FROM flights_classes fc
LEFT JOIN flights f
  ON fc.flight_id = f.flight_id
WHERE f.flight_id IS NULL;

#Verify FK → classes
SELECT COUNT(*) AS bad_class_fk
FROM flights_classes fc
LEFT JOIN classes c
  ON fc.class_id = c.class_id
WHERE c.class_id IS NULL;

#sanity join for bridge table
SELECT
  fc.flight_class_id,
  f.flight_distance,
  c.class
FROM flights_classes fc
JOIN flights f ON fc.flight_id = f.flight_id
JOIN classes c ON fc.class_id = c.class_id
LIMIT 10;


# integrity check
-- FK → flights
SELECT COUNT(*) AS bad_flight_fk
FROM flights_classes fc
LEFT JOIN flights f ON fc.flight_id = f.flight_id
WHERE f.flight_id IS NULL;

-- FK → classes
SELECT COUNT(*) AS bad_class_fk
FROM flights_classes fc
LEFT JOIN classes c ON fc.class_id = c.class_id
WHERE c.class_id IS NULL;

SELECT COUNT(*) FROM passengers;
SELECT age FROM passengers;

TRUNCATE TABLE surveys;
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE surveys;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'local_infile';


LOAD DATA LOCAL INFILE
'C:/Users/ghaza/Desktop/Airline_Passenger_Satisfaction_Project/data/clean/surveys.csv'
INTO TABLE surveys
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  id,
  passenger_id,
  inflight_wifi_service,
  departure_arrival_time_convenient,
  ease_of_online_booking,
  gate_location,
  food_and_drink,
  online_boarding,
  seat_comfort,
  inflight_entertainment,
  on_board_service,
  leg_room_service,
  baggage_handling,
  checkin_service,
  inflight_service,
  cleanliness,
  departure_delay_in_minutes,
  arrival_delay_in_minutes
);

SET FOREIGN_KEY_CHECKS = 1;

