# Airline Ticketing System Database

This project provides a database schema for a comprehensive airline ticketing system. It's designed to manage passenger information, flight details, bookings, and payments efficiently.

## Project Summary

This database project is modeled after real-world airline ticketing systems, providing a practical foundation for managing flight-related data. It enables passengers to search for flights, book tickets, and access their travel information seamlessly.

The database is comprised of six dimension tables and two transaction tables:

*   **Dimension Tables:**
    *   `Passenger`: Stores passenger details.
    *   `Flight`: Contains information about flights.
    *   `Airline`: Holds details about the airlines.
    *   `Aircraft`: Stores information about the aircraft.
    *   `Seat`: Manages seat details and availability.
    *   `Airport`: Contains information about airports.
*   **Transaction Tables:**
    *   `Booking`: Records booking information.
    *   `Payment`: Tracks payment details.

This database schema is designed to be robust and scalable, making it suitable for use in real-world business applications.

## ERD Diagram

<img width="452" alt="image" src="https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/bdbc262a-dcf1-4cbb-8aed-a62c7c310fe9">

## Getting Started

To get started with this database, you can use the provided `.sql` file to create the database schema and populate it with sample data.

1.  **Create the database:** Create a new database in your preferred database management system (e.g., MySQL, PostgreSQL, SQL Server).
2.  **Import the `.sql` file:** Import the `AirlineTicketingSystemDB.sql` file into your newly created database. This will create the tables, views, triggers, and stored procedures.
3.  **Explore the database:** You can now explore the database and run queries against it.

## Database Schema

### Views

*   **`PassengerBookingView`**: This view allows you to see the booking status for each passenger, including their reservation ID, flight number, and seat number.

    ![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/394f7ee0-47e7-4615-a37a-f9624327a622)

*   **`FlightSeatStatusView`**: This view enables you to check the seat availability for a specific flight, making it easy to determine which seats are available for booking.

*   **`PaymentSummaryView`**: This view provides a summary of payment information, including the amount paid for each transaction and the payment method used.

    ![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/207dbb47-aca0-4894-86bb-9d194251de7c)

### Audit Tables

An audit table has been implemented for the `Airport` table. A trigger automatically records any changes (inserts, updates, or deletes) to the `Airport` table in the audit table, providing a history of all modifications.

![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/2796cfe6-97d7-45de-9569-ff10607d8127)

### Stored Procedures

*   **`GetFlightInfo`**: This stored procedure retrieves detailed information about a specific flight.
*   **`UpdateSeatAvailability`**: This stored procedure updates the availability of a seat.
*   **`UpdateBookingStatus`**: This stored procedure changes the booking status of a seat. For example, it can be used to change the `IsBooked` status of a seat to `0`.

    ![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/c606cf9a-e789-4c1e-98b2-a86f676ad0fa)

### Cursors

*   **`PassengerInfoCursor`**: This cursor retrieves passenger information for a specific flight.
*   **`UpdateSeatPricesCursor`**: This cursor updates the price of all business class seats to a specified value (e.g., 250).

    ![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/3d308072-42f2-4f41-9f8a-1f2b5384d380)

## Future Enhancements

*   **Online Booking System:** Develop a web-based application that allows passengers to book flights and manage their reservations online.
*   **Reporting and Analytics:** Implement a reporting and analytics module that provides insights into flight occupancy, revenue, and other key metrics.
*   **Integration with Third-Party APIs:** Integrate with third-party APIs to provide additional services, such as weather forecasts, flight tracking, and hotel bookings.