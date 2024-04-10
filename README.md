# AirlineTicketingSystemDB
Airline ticketing system database

## Project summary

This project was designed with ideas taken from airline ticketing systems. It is designed to help passengers conveniently search and book tickets on many flights and quickly access the information they need. This database consists of 6 dimension tables and 2 transaction tables. The dimension table has passenger, flight, airline, aircraft, seat, and airport tables, and the transaction table has booking and payment tables. The airline database is a database that can be commonly used in actual business settings, and it is believed that through this exercise, you will be able to experience a closer experience to the field.


## ERD Diagram

<img width="452" alt="image" src="https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/bdbc262a-dcf1-4cbb-8aed-a62c7c310fe9">


## Sample View tables

PassengerBookingView
	This view table is a view table that allows me to view the reservation status for each passenger. Each passenger can see their reservation ID, flight number, and seat number.
 
 ![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/394f7ee0-47e7-4615-a37a-f9624327a622)

FlightSeatStatusView
	This viewtable allows you to check the seat availability of the aircraft. When making a reservation, I can check whether a specific seat on the aircraft is available.
 
PaymentSummaryView
	This viewtable allows you to check payment information. I can see how much was paid for each transaction and how.

![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/207dbb47-aca0-4894-86bb-9d194251de7c)


## Audit Tables

Create trigger

 I created an audit table against the airport table. When the airport table is entered, modified, or deleted using a trigger, this information is left in the audit table.

![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/2796cfe6-97d7-45de-9569-ff10607d8127)


## Stored Procedures

I created a stored procedure to view information about a flight and another to update seat availability. There is also an executable statement that drops if the corresponding procedure exists.
  
	Next is the procedure to change the booking status. With this processor, the IsBook of seat ID S001 can be changed to 0.
 
![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/c606cf9a-e789-4c1e-98b2-a86f676ad0fa)


## Applied Cursor

Create cursor to retrieve passenger information
	Below is a cursor representing passenger information for a specific flight.
  
When I run this cursor, I can see the following information:
 
Cursor to update seat prices
	The following is a cursor that modifies the price of only the business class seat to 250.
 
![image](https://github.com/skang88/AirlineTicketingSystemDB/assets/142484222/3d308072-42f2-4f41-9f8a-1f2b5384d380)
