<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 350px;
            margin: 50px auto;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 6px;
            box-sizing: border-box;
        }
        .inline-radio {
            margin-bottom: 10px;
        }
        .inline-radio input {
            margin-right: 5px;
        }
        .btn {
            background: #007BFF;
            color: white;
            border: none;
            padding: 7px;
            width: 100%;
            cursor: pointer;
        }
        .btn:hover {
            background: #0056b3;
        }
        .error {
            color: red;
            font-size: 12px;
        }
        .login-link {
            text-align: center;
            margin-top: 10px;
            font-size: 13px;
        }
        .login-link a {
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>User Registration</h2>

            <asp:Label ID="lblMessage" runat="server"></asp:Label>

            <div class="form-group">
                <asp:TextBox ID="txtName" runat="server" placeholder="Full Name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required." CssClass="error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email is required." CssClass="error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Enter a valid email." CssClass="error" Display="Dynamic" />
            </div>

            <div class="inline-radio">
                <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" />
                <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" />
            </div>

            <div class="form-group">
                <asp:TextBox ID="txtMobile" runat="server" placeholder="Mobile Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                    ErrorMessage="Mobile number required." CssClass="error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                    ValidationExpression="^[0-9]{10}$"
                    ErrorMessage="Enter a valid 10-digit number." CssClass="error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" placeholder="Address"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                    ErrorMessage="Address is required." CssClass="error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password is required." CssClass="error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn" OnClick="btnRegister_Click" />
            </div>

            <div class="login-link">
                Already have an account? <a href="loginForm.aspx">Login</a>
            </div>
        </div>
    </form>
</body>
</html>
