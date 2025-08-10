<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEvent.aspx.cs" Inherits="AddEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style>
        .form-container {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-family: Arial, sans-serif;
        }

        .form-container input, .form-container select {
            width: 95%;
            margin: 10px 0;
            padding: 8px;
            font-size: 14px;
            box-sizing:border-box;
        }

        .form-container input[type="submit"], .form-container button {
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            margin-right: 5px;
            padding: 8px 15px;
            border-radius: 5px;
        }

        .form-container input[type="submit"]:hover, .form-container button:hover {
            background-color: #0056b3;
        }

        .message {
            color: green;
        }

        .error {
            color: red;
        }

        .gridview {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
        }

        .gridview th, .gridview td {
            padding: 8px;
            text-align: left;
        }

        .gridview th {
            color: black;
        }

        .btn-action {
            padding: 5px 10px;
            margin-right: 5px;
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-edit {
            background-color: #28a745;
        }

        .btn-edit:hover {
            background-color: #218838;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Add New Event</h2>

            <asp:Label ID="lblMessage" runat="server"></asp:Label>

            <asp:TextBox ID="txtName" runat="server" placeholder="Event Name" />
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                ErrorMessage="Name is required." CssClass="error" Display="Dynamic" />

            <asp:TextBox ID="txtCategory" runat="server" placeholder="Category" />
            <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="txtCategory"
                ErrorMessage="Category is required." CssClass="error" Display="Dynamic" />

            <asp:TextBox ID="txtLocation" runat="server" placeholder="Location" />
            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="txtLocation"
                ErrorMessage="Location is required." CssClass="error" Display="Dynamic" />

            <asp:TextBox ID="txtPrice" runat="server" placeholder="Price" />
            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice"
                ErrorMessage="Price is required." CssClass="error" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice"
                ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="Enter a valid price."
                CssClass="error" Display="Dynamic" />

           <asp:TextBox ID="txtDate" runat="server" placeholder="DD/MM/YYYY" />
<asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate"
    ErrorMessage="Date is required." CssClass="error" Display="Dynamic" />
<asp:RegularExpressionValidator ID="revDate" runat="server" ControlToValidate="txtDate"
    ValidationExpression="^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$"
    ErrorMessage="Enter a valid date format (DD/MM/YYYY)." CssClass="error" Display="Dynamic" />


            <asp:TextBox ID="txtTickets" runat="server" placeholder="No. of Tickets" />
            <asp:RequiredFieldValidator ID="rfvTickets" runat="server" ControlToValidate="txtTickets"
                ErrorMessage="Tickets count required." CssClass="error" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revTickets" runat="server" ControlToValidate="txtTickets"
                ValidationExpression="^\d+$" ErrorMessage="Enter a valid number."
                CssClass="error" Display="Dynamic" />

            <div>
                <asp:Button ID="btnAdd" runat="server" Text="Add Event" OnClick="btnAdd_Click" />
                <asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" CausesValidation="false" />
                <asp:Button ID="btnHome" runat="server" Text="Back to Home" OnClick="backHome_Click" CausesValidation="false" />
            </div>
        </div>

        <asp:GridView ID="gvEvents" runat="server" CssClass="gridview" AutoGenerateColumns="false" EmptyDataText="No events found.">
            <Columns>
                <asp:BoundField DataField="EventName" HeaderText="Event Name" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="EventDate" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="Tickets count" HeaderText="Tickets Available" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
