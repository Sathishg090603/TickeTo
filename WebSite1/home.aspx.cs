using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

public partial class home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindBookingsGrid();
        }
    }


    private void BindBookingsGrid()
    {
        if (Session["UserID"] == null)
        {
            // User not logged in, hide bookings or redirect to login page
            GridViewBookings.Visible = false;
            return;
        }

        int userId = (int)Session["UserID"];
        string connStr = ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;
        using (OleDbConnection conn = new OleDbConnection(connStr))
        {
            string query = @"SELECT EventName, BookingDate, TicketCount 
                             FROM Bookings 
                             WHERE user_id = ? 
                             ORDER BY BookingDate DESC";

            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("?", userId);
                using (OleDbDataAdapter adapter = new OleDbDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewBookings.DataSource = dt;
                    GridViewBookings.DataBind();
                }
            }
        }
    }
}
