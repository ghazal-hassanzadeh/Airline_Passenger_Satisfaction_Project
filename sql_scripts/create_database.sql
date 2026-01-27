CREATE TABLE IF NOT EXISTS `gender` (
	`gender_id` INTEGER NOT NULL UNIQUE,
	`gender_type` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`gender_id`)
);


CREATE TABLE IF NOT EXISTS `travel_type` (
	`travel_type_id` INTEGER NOT NULL UNIQUE,
	`type_of_travel` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`travel_type_id`)
);


CREATE TABLE IF NOT EXISTS `customer_type` (
	`customer_type_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`customer_type` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`customer_type_id`)
);


CREATE TABLE IF NOT EXISTS `survey` (
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
	`on-board_service` INTEGER NOT NULL,
	`leg_room_service` INTEGER NOT NULL,
	`baggage_handling` INTEGER NOT NULL,
	`checkin_service` INTEGER NOT NULL,
	`inflight_service` INTEGER NOT NULL,
	`cleanliness` INTEGER NOT NULL,
	`departure_delay_in_minutes` INTEGER NOT NULL,
	`arrival_delay_in_minutes` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);


CREATE TABLE IF NOT EXISTS `passenger` (
	`passenger_id` INTEGER NOT NULL UNIQUE,
	`age` INTEGER NOT NULL,
	`flight_id` INTEGER NOT NULL,
	`gender_id` INTEGER NOT NULL,
	`travel_type_id` INTEGER NOT NULL,
	`satisfaction_id` INTEGER NOT NULL,
	`customer_type_id` INTEGER NOT NULL,
	PRIMARY KEY(`passenger_id`)
);


CREATE TABLE IF NOT EXISTS `satisfaction` (
	`satisfaction_id` INTEGER NOT NULL UNIQUE,
	`satisfaction` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`satisfaction_id`)
);


CREATE TABLE IF NOT EXISTS `flight` (
	`flight_id` INTEGER NOT NULL UNIQUE,
	`flight_distance` INTEGER NOT NULL,
	PRIMARY KEY(`flight_id`)
);


CREATE TABLE IF NOT EXISTS `class` (
	`class_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`class` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`class_id`)
);


CREATE TABLE IF NOT EXISTS `flight_class` (
	`flight_class_id` INTEGER NOT NULL UNIQUE,
	`class_id` INTEGER NOT NULL,
	`flight_id` INTEGER NOT NULL,
	PRIMARY KEY(`flight_class_id`)
);


ALTER TABLE `passenger`
ADD FOREIGN KEY(`travel_type_id`) REFERENCES `travel_type`(`travel_type_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `satisfaction`
ADD FOREIGN KEY(`satisfaction_id`) REFERENCES `passenger`(`satisfaction_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `survey`
ADD FOREIGN KEY(`passenger_id`) REFERENCES `passenger`(`passenger_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `passenger`
ADD FOREIGN KEY(`customer_type_id`) REFERENCES `customer_type`(`customer_type_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `gender`
ADD FOREIGN KEY(`gender_id`) REFERENCES `passenger`(`gender_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `flight`
ADD FOREIGN KEY(`flight_id`) REFERENCES `passenger`(`flight_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `flight`
ADD FOREIGN KEY(`flight_id`) REFERENCES `flight_class`(`flight_id`)
ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE `flight_class`
ADD FOREIGN KEY(`class_id`) REFERENCES `class`(`class_id`)
ON UPDATE CASCADE ON DELETE CASCADE;