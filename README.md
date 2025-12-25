/*******************************************************
 * README: Scalable Airline Reservation & Flight Management System
 *******************************************************

PROJECT OVERVIEW:
The Airline Reservation & Flight Management System is a SQL-based project that simulates a real-world airline management system.
The system allows:
- Managing airports, aircraft, flights, passengers, seats, bookings, and payments.
- Automatic seat allocation and booking validation.
- Generating revenue reports, flight occupancy reports, and passenger booking details.
- Handling payment status updates and automatic booking cancellation in case of failed payments.

PROJECT FEATURES:
- Airports & Aircraft Management – Track airport details and aircraft models.
- Flight Scheduling – Add flights with departure/arrival times and assigned aircraft.
- Passenger Management – Register passengers with contact details.
- Seat Management – Assign seats to aircraft with class types.
- Bookings & Payments – Create bookings, allocate seats automatically, and manage payments.
- Triggers & Stored Procedures:
    - Auto seat allocation (AllocateSeat)
    - Prevent double booking (prevent_double_booking)
    - Update payment status (UpdatePaymentStatus)
    - Auto-cancel bookings if payment fails (auto_cancel_booking)
    - Check available seats (CheckAvailableSeats)
- Reports & Queries – Generate interactive reports for flights, bookings, payments, and revenue.

DATABASE STRUCTURE:

1. Airports
| Column       | Type     | Description         |
|-------------|----------|-------------------|
| airport_id  | INT PK   | Unique airport ID  |
| airport_name| VARCHAR  | Airport name       |
| city        | VARCHAR  | City               |
| country     | VARCHAR  | Country            |
| airport_code| VARCHAR  | Airport code       |

2. Aircraft
| Column       | Type     | Description         |
|-------------|----------|-------------------|
| aircraft_id | INT PK   | Unique aircraft ID |
| model       | VARCHAR  | Aircraft model     |
| capacity    | INT      | Number of seats    |

3. Flights
| Column            | Type      | Description                       |
|------------------|-----------|-----------------------------------|
| flight_id         | INT PK    | Unique flight ID                  |
| flight_number     | VARCHAR   | Flight number                     |
| departure_airport | INT FK    | References Airports               |
| arrival_airport   | INT FK    | References Airports               |
| departure_time    | DATETIME  | Flight departure time             |
| arrival_time      | DATETIME  | Flight arrival time               |
| aircraft_id       | INT FK    | References Aircraft               |
| status            | VARCHAR   | Flight status (Scheduled/Cancelled)|

4. Passengers
| Column       | Type     | Description         |
|-------------|----------|-------------------|
| passenger_id| INT PK   | Unique passenger ID |
| full_name   | VARCHAR  | Passenger name      |
| email       | VARCHAR  | Unique email        |
| phone       | VARCHAR  | Phone number        |

5. Seats
| Column      | Type     | Description               |
|------------|----------|---------------------------|
| seat_id    | INT PK   | Unique seat ID            |
| aircraft_id| INT FK   | References Aircraft       |
| seat_number| VARCHAR  | Seat number (e.g., 1A)   |
| class      | VARCHAR  | Seat class (Business/Economy) |

6. Bookings
| Column         | Type     | Description                     |
|----------------|----------|---------------------------------|
| booking_id     | INT PK   | Unique booking ID               |
| passenger_id   | INT FK   | References Passengers           |
| flight_id      | INT FK   | References Flights              |
| seat_id        | INT FK   | References Seats                |
| booking_date   | DATE     | Date of booking                 |
| booking_status | VARCHAR  | Confirmed/Cancelled             |

7. Payments
| Column         | Type      | Description                        |
|----------------|-----------|-----------------------------------|
| payment_id     | INT PK    | Unique payment ID                  |
| booking_id     | INT FK    | References Bookings                |
| amount         | DECIMAL   | Payment amount                     |
| payment_method | VARCHAR   | Payment method (UPI, Card, NetBanking) |
| payment_status | VARCHAR   | Success/Failed                     |

STORED PROCEDURES:
- AllocateSeat(p_passenger_id, p_flight_id) – Automatically assigns the next available seat.
- CheckAvailableSeats(p_flight_id) – Lists all available seats for a flight.
- UpdatePaymentStatus(p_booking_id, p_amount, p_method) – Updates payment status.

TRIGGERS:
- prevent_double_booking – Prevent duplicate seat booking for the same flight.
- auto_cancel_booking – Automatically cancel booking if payment fails.

SAMPLE QUERIES:
- View all flights:
  SELECT f.flight_number, da.airport_code AS departure, aa.airport_code AS arrival, f.departure_time, f.arrival_time, a.model AS aircraft_model, f.status
  FROM Flights f
  JOIN Airports da ON f.departure_airport = da.airport_id
  JOIN Airports aa ON f.arrival_airport = aa.airport_id
  JOIN Aircraft a ON f.aircraft_id = a.aircraft_id;

- View passenger bookings:
  SELECT p.full_name, f.flight_number, s.seat_number, b.booking_status, b.booking_date
  FROM Bookings b
  JOIN Passengers p ON b.passenger_id=p.passenger_id
  JOIN Flights f ON b.flight_id=f.flight_id
  JOIN Seats s ON b.seat_id=s.seat_id;

- View total revenue per flight:
  SELECT f.flight_number, SUM(pay.amount) AS total_revenue
  FROM Flights f
  JOIN Bookings b ON f.flight_id=b.flight_id
  JOIN Payments pay ON b.booking_id=pay.booking_id
  WHERE pay.payment_status='Success'
  GROUP BY f.flight_number;

- Check available seats for a flight:
  CALL CheckAvailableSeats(1);

- Allocate a seat for a passenger:
  CALL AllocateSeat(1, 1);

GETTING STARTED:
1. Install MySQL Workbench or any MySQL server.
2. Copy the all-in-one SQL file (tables + data + procedures + triggers).
3. Execute the SQL script in MySQL Workbench.
4. Run sample queries to interact with the database.

LEARNING OUTCOMES:
- Designing relational databases with multiple entities.
- Implementing foreign key relationships.
- Writing stored procedures for automation.
- Using triggers to enforce business rules.
- Generating interactive reports using SQL queries.

*******************************************************/
