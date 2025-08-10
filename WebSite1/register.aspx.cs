using System;
using System.Data.OleDb;
using System.Configuration;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string gender = rbMale.Checked ? "Male" : (rbFemale.Checked ? "Female" : "");
        string email = txtEmail.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string address = txtAddress.Text.Trim();
        string password = txtPassword.Text.Trim();

        // Simple validation
        if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(gender) ||
            string.IsNullOrEmpty(email) || string.IsNullOrEmpty(mobile) ||
            string.IsNullOrEmpty(address) || string.IsNullOrEmpty(password))
        {
            lblMessage.Text = "All fields are required.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connStr = ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;

        using (OleDbConnection conn = new OleDbConnection(connStr))
        {
            string query = @"INSERT INTO Users ([name], [gender], [email], [mobile], [address], [password]) 
                 VALUES (?, ?, ?, ?, ?, ?)";


            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("?", name);
                cmd.Parameters.AddWithValue("?", gender);
                cmd.Parameters.AddWithValue("?", email);
                cmd.Parameters.AddWithValue("?", mobile);
                cmd.Parameters.AddWithValue("?", address);
                cmd.Parameters.AddWithValue("?", password);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    // Redirect to login after successful registration
                    Response.Redirect("loginForm.aspx");
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}
