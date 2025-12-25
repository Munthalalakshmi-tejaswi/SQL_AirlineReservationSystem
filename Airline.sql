CREATE DATABASE AirlineDB;
Use AirlineDB;
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    airport_code VARCHAR(10) UNIQUE NOT NULL
);

INSERT INTO Airports (airport_name, city, country, airport_code) VALUES
('Indira Gandhi International Airport','Delhi','India','DEL'),
('Chhatrapati Shivaji International Airport','Mumbai','India','BOM'),
('Kempegowda International Airport','Bengaluru','India','BLR'),
('Chennai International Airport','Chennai','India','MAA'),
('Rajiv Gandhi International Airport','Hyderabad','India','HYD'),
('Netaji Subhas Chandra Bose Airport','Kolkata','India','CCU'),
('Cochin International Airport','Kochi','India','COK'),
('Trivandrum International Airport','Trivandrum','India','TRV'),
('Pune International Airport','Pune','India','PNQ'),
('Jaipur International Airport','Jaipur','India','JAI');

CREATE TABLE Aircraft (
    aircraft_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(50),
    capacity INT CHECK (capacity > 0)
);


INSERT INTO Aircraft (model, capacity) VALUES
('Airbus A320',180),
('Boeing 737',160),
('Airbus A321',220),
('Boeing 777',300),
('Airbus A330',250),
('ATR 72',70),
('Bombardier Q400',78),
('Boeing 787 Dreamliner',290),
('Airbus A350',325),
('Embraer E190',100);

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(20) UNIQUE NOT NULL,
    departure_airport INT,
    arrival_airport INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    aircraft_id INT,
    status VARCHAR(20),
    FOREIGN KEY (departure_airport) REFERENCES Airports(airport_id),
    FOREIGN KEY (arrival_airport) REFERENCES Airports(airport_id),
    FOREIGN KEY (aircraft_id) REFERENCES Aircraft(aircraft_id)
);

INSERT INTO Flights (flight_number, departure_airport, arrival_airport, departure_time, arrival_time, aircraft_id, status) VALUES
('AI101',1,2,'2025-12-25 10:00:00','2025-12-25 12:00:00',1,'Scheduled'),
('AI102',2,3,'2025-12-25 12:00:00','2025-12-25 14:00:00',2,'Scheduled'),
('AI103',3,4,'2025-12-25 14:00:00','2025-12-25 16:00:00',3,'Scheduled'),
('AI104',4,5,'2025-12-25 16:00:00','2025-12-25 18:00:00',4,'Scheduled'),
('AI105',5,6,'2025-12-25 18:00:00','2025-12-25 20:00:00',5,'Scheduled'),
('AI106',6,1,'2025-12-25 20:00:00','2025-12-25 22:00:00',6,'Scheduled'),
('AI107',1,3,'2025-12-25 22:00:00','2025-12-26 00:00:00',7,'Scheduled'),
('AI108',3,2,'2025-12-26 08:00:00','2025-12-26 10:00:00',8,'Scheduled'),
('AI109',2,4,'2025-12-26 10:00:00','2025-12-26 12:00:00',9,'Scheduled'),
('AI110',4,1,'2025-12-26 12:00:00','2025-12-26 14:00:00',10,'Scheduled');

CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

INSERT INTO Passengers (full_name, email, phone) VALUES
('Tejaswi','mltejaswi1@gmail.com','900000001'),
('Vaishnavi','vaish1091@gmail.com','900000002'),
('Keerthana','keerthana101@gmail.com','900000003'),
('Swati','swati21@gmail.com','900000004'),
('Mokshitha','mokshi@gmail.com','900000005'),
('Jyoshitha','jyosh@gmail.com','900000006'),
('Chandana','chandu@gmail.com','900000007'),
('Sweety','sweety@gmail.com','900000008'),
('Sumaswi','suma@gmail.com','900000009'),
('Kiranmayee','kiranmayee@gmail.com','900000010');

CREATE TABLE Seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    aircraft_id INT,
    seat_number VARCHAR(5),
    class VARCHAR(20),
    FOREIGN KEY (aircraft_id) REFERENCES Aircraft(aircraft_id)
);

INSERT INTO Seats (aircraft_id, seat_number, class) VALUES
(1,'1A','Business'),
(1,'1B','Business'),
(2,'10A','Economy'),
(2,'10B','Economy'),
(3,'2A','Business'),
(3,'2B','Business'),
(4,'20A','Economy'),
(5,'15C','Economy'),
(6,'5D','Economy'),
(7,'3A','Business');

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT,
    flight_id INT,
    seat_id INT,
    booking_date DATE,
    booking_status VARCHAR(20),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);

INSERT INTO Bookings (passenger_id, flight_id, seat_id, booking_date, booking_status) VALUES
(1,1,1,'2025-12-25','Confirmed'),
(2,2,2,'2025-12-25','Confirmed'),
(3,3,3,'2025-12-25','Confirmed'),
(4,4,4,'2025-12-25','Confirmed'),
(5,5,5,'2025-12-25','Confirmed'),
(6,6,6,'2025-12-25','Confirmed'),
(7,7,7,'2025-12-25','Confirmed'),
(8,8,8,'2025-12-25','Confirmed'),
(9,9,9,'2025-12-25','Confirmed'),
(10,10,10,'2025-12-25','Confirmed');

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO Payments (booking_id, amount, payment_method, payment_status) VALUES
(1,5500,'UPI','Success'),
(2,4200,'Card','Success'),
(3,6100,'NetBanking','Success'),
(4,4800,'UPI','Success'),
(5,5300,'Card','Success'),
(6,3900,'UPI','Success'),
(7,7200,'Card','Success'),
(8,4600,'UPI','Success'),
(9,5000,'NetBanking','Success'),
(10,6800,'Card','Success');

SELECT * FROM flights;

SELECT flight_number,departure_time,arrival_time 
FROM Flights 
WHERE departure_airport=1;

SELECT flight_number,departure_time,arrival_time 
FROM Flights 
WHERE arrival_time=2;

SELECT f.flight_number,a.model AS aircraft_model,f.departure_time,f.arrival_time 
FROM Flights f 
JOIN Aircraft a ON f.aircraft_id=a.aircraft_id;

SELECT * FROM Passengers;

SELECT p.full_name, f.flight_number, f.departure_time, f.arrival_time, b.booking_status
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id;

SELECT s.seat_number
FROM Seats s
WHERE s.aircraft_id = (SELECT aircraft_id FROM Flights WHERE flight_id = 1)
AND s.seat_id NOT IN (SELECT seat_id FROM Bookings WHERE flight_id = 1 AND booking_status='Confirmed');

SELECT b.booking_id, p.full_name, f.flight_number, s.seat_number
FROM Bookings b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id
WHERE b.booking_status='Confirmed';

UPDATE Bookings SET booking_status='Cancelled' WHERE booking_id=5;

DELETE FROM Payments WHERE payment_status='Failed';

SELECT SUM(amount) AS Total_Revenue
FROM Payments
WHERE payment_status='Success';

SELECT f.flight_number, COUNT(b.passenger_id) AS total_passengers
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id
WHERE b.booking_status='Confirmed'
GROUP BY f.flight_number;

SELECT f.flight_number, f.departure_time, f.arrival_time
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_id
WHERE b.passenger_id=1;

SELECT b.booking_id, p.full_name, f.flight_number, pay.amount, pay.payment_status
FROM Bookings b
JOIN Passengers p ON b.passenger_id=p.passenger_id
JOIN Flights f ON b.flight_id=f.flight_id
JOIN Payments pay ON b.booking_id=pay.booking_id;

SELECT f.flight_number, COUNT(b.booking_id) AS bookings_count
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id=b.flight_id
GROUP BY f.flight_number;

SELECT flight_number, departure_time, arrival_time
FROM Flights
WHERE aircraft_id = 1;

SELECT * FROM Payments WHERE payment_method='UPI';

SELECT flight_number, departure_time
FROM Flights
WHERE departure_time BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 1 DAY);

SELECT a.model, COUNT(s.seat_id) AS total_seats
FROM Aircraft a
JOIN Seats s ON a.aircraft_id = s.aircraft_id
GROUP BY a.model;

SELECT f.flight_number, COUNT(b.passenger_id) AS passenger_count
FROM Flights f
JOIN Bookings b ON f.flight_id=b.flight_id
WHERE b.booking_status='Confirmed'
GROUP BY f.flight_number;

SELECT status, COUNT(flight_id) AS total_flights
FROM Flights
GROUP BY status;

SELECT p.full_name, pay.amount, pay.payment_method
FROM Passengers p
JOIN Bookings b ON p.passenger_id=b.passenger_id
JOIN Payments pay ON b.booking_id=pay.booking_id
WHERE pay.payment_status='Success';

SELECT b.booking_id, p.full_name, f.flight_number, s.seat_number, b.booking_status, b.booking_date
FROM Bookings b
JOIN Passengers p ON b.passenger_id = p.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id
WHERE b.flight_id = 1;
