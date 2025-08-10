<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchEvent.aspx.cs" Inherits="SearchEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Search Events</title>
    <style>
        .btn-book {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 5px 12px;
            cursor: pointer;
            border-radius: 4px;
        }
        .btn-book:hover {
            background-color: #0056b3;
        }
        .search-container {
            width: 90%;
            margin: 20px auto;
            font-family: Arial, sans-serif;
        }
        .search-container input[type="text"] {
            width: 250px;
            padding: 7px;
            font-size: 14px;
        }
        .search-container input[type="submit"] {
            padding: 7px 15px;
            font-size: 14px;
            cursor: pointer;
            background-color: #007BFF;
            border: none;
            color: white;
            border-radius: 4px;
            margin-left: 5px;
        }
        .search-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="search-container">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by Event Name"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CausesValidation="false" />
            <asp:Button ID="btnHome" runat="server" Text="Home" CssClass="btn-home" OnClick="btnHome_Click" CausesValidation="false" />
            
        </div>
        <asp:GridView ID="gvEvents" runat="server" CssClass="gridview" AutoGenerateColumns="false" EmptyDataText="No events found." OnRowCommand="gvEvents_RowCommand">
            <Columns>
                <asp:BoundField DataField="EventName" HeaderText="Event Name" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="EventDate" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="Tickets count" HeaderText="Tickets Available" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnBookNow" runat="server" Text="Book Now" CssClass="btn-book" CommandName="BookNow" CommandArgument='<%# Eval("EventName") %>' CausesValidation="false" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
