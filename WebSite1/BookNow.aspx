<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookNow.aspx.cs" Inherits="BookNow" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Book Event</title>
    <style>
        .form-container {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-family: Arial, sans-serif;
        }
        .form-container label, .form-container input {
            display: block;
            margin-bottom: 10px;
            width: 95%;
            font-size: 14px;
        }
        .form-container input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            padding: 8px 15px;
            border-radius: 5px;
        }
        .form-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .message {
            color: green;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Book Event</h2>
            <asp:Label ID="lblMessage" runat="server"></asp:Label>

            <asp:Label ID="lblEventName" runat="server" Font-Bold="true" />
            <asp:Label ID="lblCategory" runat="server" />
            <asp:Label ID="lblLocation" runat="server" />
            <asp:Label ID="lblPrice" runat="server" />
            <asp:Label ID="lblDate" runat="server" />
            <asp:Label ID="lblTicketsAvailable" runat="server" />

            <asp:Label ID="Label1" Text="Number of Tickets to Book:" AssociatedControlID="txtTicketsToBook" runat="server" />
            <asp:TextBox ID="txtTicketsToBook" runat="server" />
            <asp:RequiredFieldValidator ID="rfvTickets" ControlToValidate="txtTicketsToBook" ErrorMessage="Enter tickets count" CssClass="error" runat="server" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revTickets" ControlToValidate="txtTicketsToBook" ValidationExpression="^\d+$" ErrorMessage="Enter a valid number" CssClass="error" runat="server" Display="Dynamic" />

            <asp:Button ID="btnBook" runat="server" Text="Book Now" OnClick="btnBook_Click" />
        </div>
    </form>
</body>
</html>
