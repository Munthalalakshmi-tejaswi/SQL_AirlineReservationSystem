
Scalable Airline Reservation & Flight Management System
Project Overview

The Airline Reservation & Flight Management System is a SQL-based project designed to simulate a real-world airline management system. The system allows:

Managing airports, aircraft, flights, passengers, seats, bookings, and payments.

Performing automatic seat allocation and booking validation.

Generating revenue reports, flight occupancy reports, and passenger booking details.

Handling payment status updates and automatic booking cancellation in case of failed payments.

This project is suitable for learning SQL, database relationships, triggers, stored procedures, and advanced queries.

Project Features

Airports & Aircraft Management – Track airport details and aircraft models.

Flight Scheduling – Add flights with departure/arrival times and assigned aircraft.

Passenger Management – Register passengers with contact details.

Seat Management – Assign seats to aircraft with class types.

Bookings & Payments – Create bookings, allocate seats automatically, and manage payments.

Triggers & Stored Procedures –

Auto seat allocation (AllocateSeat)

Prevent double booking (prevent_double_booking)

Update payment status (UpdatePaymentStatus)

Auto-cancel bookings if payment fails (auto_cancel_booking)

Check available seats (CheckAvailableSeats)

Reports & Queries – Generate interactive reports for flights, bookings, payments, and revenue.

Database Structure
1. Airports
Column	Type	Description
airport_id	INT PK	Unique airport ID
airport_name	VARCHAR	Airport name
city	VARCHAR	City
country	VARCHAR	Country
airport_code	VARCHAR	Airport code
2. Aircraft
Column	Type	Description
aircraft_id	INT PK	Unique aircraft ID
model	VARCHAR	Aircraft model
capacity	INT	Number of seats
3. Flights
Column	Type	Description
flight_id	INT PK	Unique flight ID
flight_number	VARCHAR	Flight number
departure_airport	INT FK	References Airports
arrival_airport	INT FK	References Airports
departure_time	DATETIME	Flight departure time
arrival_time	DATETIME	Flight arrival time
aircraft_id	INT FK	References Aircraft
status	VARCHAR	Flight status (Scheduled/Cancelled)
4. Passengers
Column	Type	Description
passenger_id	INT PK	Unique passenger ID
full_name	VARCHAR	Passenger name
email	VARCHAR	Unique email
phone	VARCHAR	Phone number
5. Seats
Column	Type	Description
seat_id	INT PK	Unique seat ID
aircraft_id	INT FK	References Aircraft
seat_number	VARCHAR	Seat number (e.g., 1A)
class	VARCHAR	Seat class (Business/Economy)
6. Bookings
Column	Type	Description
booking_id	INT PK	Unique booking ID
passenger_id	INT FK	References Passengers
flight_id	INT FK	References Flights
seat_id	INT FK	References Seats
booking_date	DATE	Date of booking
booking_status	VARCHAR	Confirmed/Cancelled
7. Payments
Column	Type	Description
payment_id	INT PK	Unique payment ID
booking_id	INT FK	References Bookings
amount	DECIMAL	Payment amount
payment_method	VARCHAR	Payment method (UPI, Card, NetBanking)
payment_status	VARCHAR	Success/Failed
Stored Procedures & Triggers

AllocateSeat(p_passenger_id, p_flight_id) – Automatically assigns the next available seat.

CheckAvailableSeats(p_flight_id) – Lists all available seats for a flight.

UpdatePaymentStatus(p_booking_id, p_amount, p_method) – Updates payment status.

prevent_double_booking – Trigger to prevent duplicate seat booking.

auto_cancel_booking – Trigger to cancel booking if payment fails.
