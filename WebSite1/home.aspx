    <%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Event List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
            }

            .navbar {
                background-color: #333;
                overflow: hidden;
            }

            .navbar a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }

            .navbar a:hover {
                background-color: #575757;
            }

            .event-table {
                margin: 50px auto;
                width: 90%;
                border-collapse: collapse;
            }

            .event-table th, .event-table td {
                border: 1px solid #ccc;
                padding: 10px;
            }

            .event-table th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <a href="Home.aspx">Home</a>
            <a href="AddEvent.aspx">Add Event</a>
            <a href="SearchEvent.aspx">Search Event</a>
            <a href="loginForm.aspx">Logout</a>
        </div>

        <form id="form1" runat="server">
             <asp:GridView ID="GridViewBookings" runat="server" CssClass="booking-table" AutoGenerateColumns="false" EmptyDataText="No bookings found.">
                <Columns>
                    <asp:BoundField DataField="EventName" HeaderText="Event Name" />
                    <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" DataFormatString="{0:MM/dd/yyyy HH:mm}" />
                    <asp:BoundField DataField="TicketCount" HeaderText="Tickets Booked" />
                </Columns>
            </asp:GridView>
        </form>
    </body>
    </html>
