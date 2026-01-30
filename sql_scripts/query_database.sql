/*
Project: Airline Passenger Satisfaction
Step: SQL Analysis & Validation
Author: Ghazal Hassanzadeh
Date: 28/01/2026

Purpose:
- Validate data integrity after import
- Perform SQL-based analysis aligned with research questions
*/


SHOW DATABASES;

USE airline_passenger_satisfaction;
SHOW TABLES;

-- =====================================================
-- DATA SANITY CHECK
-- =====================================================

SELECT 'classes' AS table_name, COUNT(*) AS row_count FROM classes
UNION ALL
SELECT 'customer_types', COUNT(*) FROM customer_types
UNION ALL
SELECT 'flights', COUNT(*) FROM flights
UNION ALL
SELECT 'flights_classes', COUNT(*) FROM flights_classes
UNION ALL
SELECT 'genders', COUNT(*) FROM genders
UNION ALL
SELECT 'passengers', COUNT(*) FROM passengers
UNION ALL
SELECT 'satisfactions', COUNT(*) FROM satisfactions
UNION ALL
SELECT 'surveys', COUNT(*) FROM surveys
UNION ALL
SELECT 'travel_types', COUNT(*) FROM travel_types;

-- All tables were loaded successfully and the row counts match the expected structure of the dataset.


-- =====================================================
-- Foreign key validation
-- =====================================================
-- surveys → passengers
SELECT COUNT(*) AS orphan_surveys
FROM surveys s
LEFT JOIN passengers p 
  ON p.passenger_id = s.passenger_id
WHERE p.passenger_id IS NULL;

-- Result expected: 0 (no orphan records). Every survey record is linked to a valid passenger; no orphan surveys were found.

-- passengers → satisfactions
SELECT COUNT(*) AS orphan_passengers_satisfaction
FROM passengers p
LEFT JOIN satisfactions s
  ON s.satisfaction_id = p.satisfaction_id
WHERE s.satisfaction_id IS NULL;

-- Result expected: 0 (no orphan records). All passengers have a valid satisfaction label, so the target variable is complete.

-- passengers → flights
SELECT COUNT(*) AS orphan_passengers_flights
FROM passengers p
LEFT JOIN flights f
  ON f.flight_id = p.flight_id
WHERE f.flight_id IS NULL;

-- Result expected: 0 (no orphan records). -- Each passenger is linked to a valid flight, allowing reliable analysis of flight-related features.


-- Conclusion: Foreign key relationships across core analytical tables were validated, and there is a full referential integrity.

-- =====================================================
-- Analysis View (one row per passenger journey)
-- =====================================================
DESCRIBE surveys;
-- Checked survey column names to avoid errors when building the analysis view.


CREATE OR REPLACE VIEW v_passenger_journey AS
SELECT
    p.passenger_id,
    p.age,

    g.gender,
    ct.customer_type,
    tt.type_of_travel,

    f.flight_distance,

    c.class,

    s.satisfaction AS satisfaction_label,

    sv.inflight_wifi_service,
    sv.departure_arrival_time_convenient,
    sv.ease_of_online_booking,
    sv.gate_location,
    sv.food_and_drink,
    sv.online_boarding,
    sv.seat_comfort,
    sv.inflight_entertainment,
    sv.on_board_service,
    sv.leg_room_service,
    sv.baggage_handling,
    sv.checkin_service,
    sv.inflight_service,
    sv.cleanliness,
    sv.departure_delay_in_minutes,
    sv.arrival_delay_in_minutes
FROM passengers p
JOIN satisfactions s        ON s.satisfaction_id = p.satisfaction_id
JOIN surveys sv             ON sv.passenger_id = p.passenger_id
JOIN flights f              ON f.flight_id = p.flight_id
JOIN genders g              ON g.gender_id = p.gender_id
JOIN travel_types tt        ON tt.travel_type_id = p.travel_type_id
JOIN customer_types ct      ON ct.customer_type_id = p.customer_type_id
LEFT JOIN flights_classes fc ON fc.flight_id = f.flight_id
LEFT JOIN classes c          ON c.class_id = fc.class_id;

SELECT * FROM v_passenger_journey LIMIT 10;
-- Built a single analysis view that combines passenger, flight, service, and satisfaction data.



-- =====================================================
-- KPI - Overall Satisfaction Rate
-- =====================================================

-- Baseline KPI: overall passenger satisfaction rate.
SELECT
  COUNT(*) AS total_passengers,
  SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) AS satisfied_passengers,
  ROUND(
    SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) 
    / COUNT(*) * 100, 
    2
  ) AS satisfaction_rate_percent
FROM v_passenger_journey;

-- Only about 43% of passengers are satisfied, which shows low overall satisfaction and a clear need for improvement.



-- Satisfaction by Travel Type
SELECT
  type_of_travel,
  COUNT(*) AS total_passengers,
  SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) AS satisfied_passengers,
  ROUND(
    SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) / COUNT(*) * 100,
    2
  ) AS satisfaction_rate_percent
FROM v_passenger_journey
GROUP BY type_of_travel
ORDER BY satisfaction_rate_percent DESC;

-- Business travelers report much higher satisfaction than personal travelers,
-- which shows travel purpose strongly influences passenger satisfaction.



-- Satisfaction by Customer Type
SELECT
  customer_type,
  COUNT(*) AS total_passengers,
  SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) AS satisfied_passengers,
  ROUND(
    SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) / COUNT(*) * 100,
    2
  ) AS satisfaction_rate_percent
FROM v_passenger_journey
GROUP BY customer_type
ORDER BY satisfaction_rate_percent DESC;
-- Loyal customers show much higher satisfaction levels than disloyal customers,
-- indicating a strong link between loyalty and satisfaction.



-- Satisfaction vs Delays (Delay Buckets)
SELECT
  CASE
    WHEN arrival_delay_in_minutes IS NULL OR arrival_delay_in_minutes = 0 THEN 'No delay'
    WHEN arrival_delay_in_minutes BETWEEN 1 AND 15 THEN '1–15 min'
    WHEN arrival_delay_in_minutes BETWEEN 16 AND 60 THEN '16–60 min'
    ELSE '60+ min'
  END AS delay_bucket,
  COUNT(*) AS total_passengers,
  SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) AS satisfied_passengers,
  ROUND(
    SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) / COUNT(*) * 100,
    2
  ) AS satisfaction_rate_percent
FROM v_passenger_journey
GROUP BY delay_bucket
ORDER BY satisfaction_rate_percent DESC;

-- Satisfaction declines as arrival delays increase, with on-time flights having
-- the highest satisfaction and long delays the lowest.

-- Average service scores by satisfaction
SELECT
  satisfaction_label,

  ROUND(AVG(inflight_wifi_service), 2)                AS inflight_wifi,
  ROUND(AVG(departure_arrival_time_convenient), 2)   AS time_convenience,
  ROUND(AVG(ease_of_online_booking), 2)              AS online_booking,
  ROUND(AVG(gate_location), 2)                        AS gate_location,
  ROUND(AVG(food_and_drink), 2)                       AS food_and_drink,
  ROUND(AVG(online_boarding), 2)                      AS online_boarding,
  ROUND(AVG(seat_comfort), 2)                         AS seat_comfort,
  ROUND(AVG(inflight_entertainment), 2)               AS inflight_entertainment,
  ROUND(AVG(on_board_service), 2)                     AS on_board_service,
  ROUND(AVG(leg_room_service), 2)                     AS leg_room_service,
  ROUND(AVG(baggage_handling), 2)                     AS baggage_handling,
  ROUND(AVG(checkin_service), 2)                      AS checkin_service,
  ROUND(AVG(inflight_service), 2)                     AS inflight_service,
  ROUND(AVG(cleanliness), 2)                          AS cleanliness

FROM v_passenger_journey
GROUP BY satisfaction_label;

-- Satisfied passengers consistently rate all service areas higher, with the
-- largest gaps in online boarding, seat comfort, inflight entertainment,
-- leg room service, and inflight service.

-- Can good service reduce dissatisfaction during delays?
SELECT
  CASE
    WHEN online_boarding >= 4 THEN 'High service quality'
    ELSE 'Low service quality'
  END AS service_quality_group,

  COUNT(*) AS total_passengers,
  SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) AS satisfied_passengers,
  ROUND(
    SUM(CASE WHEN satisfaction_label = 'Satisfied' THEN 1 ELSE 0 END) / COUNT(*) * 100,
    2
  ) AS satisfaction_rate_percent
FROM v_passenger_journey
WHERE arrival_delay_in_minutes > 15
GROUP BY service_quality_group
ORDER BY satisfaction_rate_percent DESC;

-- High service quality strongly mitigates the negative impact of flight delays,
-- with delayed passengers reporting much higher satisfaction when service quality is high.

-- =====================================================
-- KEY FINDINGS (SQL CONCLUSIONS)
-- =====================================================

-- 1. Overall passenger satisfaction is low, with only about 43% of passengers reporting satisfaction.

-- 2. Business travelers are significantly more satisfied than personal travelers
--    (approximately 58% vs. 10%), indicating that travel purpose strongly affects satisfaction.

-- 3. Loyal customers show much higher satisfaction levels than disloyal customers,
--    highlighting the importance of customer retention and loyalty programs.

-- 4. Passenger satisfaction decreases as arrival delays increase,
--    with long delays (60+ minutes) showing the lowest satisfaction levels.

-- 5. Satisfied passengers rate all service categories higher,
--    with the largest gaps in online boarding, seat comfort,
--    inflight entertainment, leg room service, and inflight service.

-- 6. High service quality can strongly mitigate the negative impact of delays,
--    as delayed passengers with high service quality report much higher satisfaction
--    than those with low service quality.



-- =====================================================
-- BUSINESS RECOMMENDATIONS
-- =====================================================

-- 1. Focus improvement efforts on online boarding, seat comfort,
--    inflight entertainment, leg room, and inflight service,
--    as these have the strongest impact on passenger satisfaction.

-- 2. Use high service quality to offset delays, since good service
--    significantly reduces dissatisfaction even when flights are late.

-- 3. Strengthen loyalty programs, as loyal customers are far more
--    satisfied than disloyal customers.

-- 4. Improve the personal travel experience, which currently shows
--    much lower satisfaction compared to business travel.

-- 5. Minimize long delays whenever possible, as extended delays
--    have a clear negative effect on satisfaction.
