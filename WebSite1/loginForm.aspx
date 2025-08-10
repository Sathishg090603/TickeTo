<%@ Page Language="C#" AutoEventWireup="true" CodeFile="loginForm.aspx.cs" Inherits="loginForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 300px;
            margin: 80px auto;
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
        .form-group input {
            width: 100%;
            padding: 6px;
            box-sizing: border-box;
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
        .register {
            text-align: center;
            margin-top: 10px;
            font-size: 13px;
        }
        .register-link a {
             color: #007BFF;

        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>User Login</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="error"></asp:Label>

            <div class="form-group">
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
            </div>

            <div class="register">
                Don't have an account? <a href="Register.aspx">Register</a>
            </div>
        </div>
    </form>
</body>
</html>
