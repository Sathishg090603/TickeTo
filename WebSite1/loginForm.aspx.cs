using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Configuration;

public partial class loginForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();

        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;

        using (OleDbConnection conn = new OleDbConnection(connStr))
        {
            string query = "SELECT user_id FROM Users WHERE email = ? AND password = ?";
            OleDbCommand cmd = new OleDbCommand(query, conn);
            cmd.Parameters.AddWithValue("?", email);
            cmd.Parameters.AddWithValue("?", password);

            conn.Open();
            object result = cmd.ExecuteScalar();
            if (result != null && result != DBNull.Value)
            {
                int userId = Convert.ToInt32(result);
                Session["UserID"] = userId; // Store actual user ID
                txtEmail.Text =Convert.ToString(userId);
                Response.Redirect("Home.aspx");
            }
            else
            {
                // ❌ Login failed
                lblMessage.Text = "Invalid email or password.";
            }
        }
    }
}