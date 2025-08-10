using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

public partial class BookNow : System.Web.UI.Page
{
    string eventName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            eventName = Request.QueryString["event"];
            if (string.IsNullOrEmpty(eventName))
            {
                lblMessage.CssClass = "error";
                lblMessage.Text = "No event specified.";
                btnBook.Enabled = false;
                return;
            }
            LoadEventDetails(eventName);
        }
    }

    private void LoadEventDetails(string name)
    {
        string connStr = ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;
        using (OleDbConnection conn = new OleDbConnection(connStr))
        {
            conn.Open();
            string query = "SELECT [EventName], [Category], [Location], [Price], [EventDate], [Tickets count] FROM Events WHERE EventName = ?";
            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("?", name);
                using (OleDbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblEventName.Text = "Event: " + reader["EventName"].ToString();
                        lblCategory.Text = "Category: " + reader["Category"].ToString();
                        lblLocation.Text = "Location: " + reader["Location"].ToString();
                        lblPrice.Text = "Price: " + Convert.ToDecimal(reader["Price"]).ToString("C");
                        lblDate.Text = "Date: " + Convert.ToDateTime(reader["EventDate"]).ToString("MM/dd/yyyy");
                        lblTicketsAvailable.Text = "Tickets Available: " + reader["Tickets count"].ToString();
                    }
                    else
                    {
                        lblMessage.CssClass = "error";
                        lblMessage.Text = "Event not found.";
                        btnBook.Enabled = false;
                    }
                }
            }
        }
    }

protected void btnBook_Click(object sender, EventArgs e)
{
    string eventName = Request.QueryString["event"]; // get again here
    if (string.IsNullOrEmpty(eventName))
    {
        lblMessage.CssClass = "error";
        lblMessage.Text = "Event not specified.";
        return;
    }

    int ticketsToBook;
    if (!int.TryParse(txtTicketsToBook.Text.Trim(), out ticketsToBook) || ticketsToBook <= 0)
    {
        lblMessage.CssClass = "error";
        lblMessage.Text = "Please enter a valid number of tickets.";
        return;
    }

    // Check user logged in
    if (Session["UserID"] == null)
    {
        lblMessage.CssClass = "error";
        lblMessage.Text = "You must be logged in to book tickets.";
        return;
    }

    int userId = (int)Session["UserID"];
    string connStr = ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;

    using (OleDbConnection conn = new OleDbConnection(connStr))
    {
        conn.Open();

        // Check available tickets
        string checkQuery = "SELECT [Tickets count] FROM Events WHERE EventName = ?";
        using (OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn))
        {
            checkCmd.Parameters.AddWithValue("?", eventName);
            object result = checkCmd.ExecuteScalar();
            if (result == null || result == DBNull.Value)
            {
                lblMessage.CssClass = "error";
                lblMessage.Text = "Event not found.";
                return;
            }

            int availableTickets = Convert.ToInt32(result);

            if (ticketsToBook > availableTickets)
            {
                lblMessage.CssClass = "error";
                lblMessage.Text = "Only ${availableTickets} tickets are available.";
                return;
            }
        }

        // Begin transaction (optional but recommended)
        using (OleDbTransaction transaction = conn.BeginTransaction())
        {
            try
            {
                // Update tickets count after booking
                string updateQuery = "UPDATE Events SET [Tickets count] = [Tickets count] - ? WHERE EventName = ?";
                using (OleDbCommand updateCmd = new OleDbCommand(updateQuery, conn, transaction))
                {
                    updateCmd.Parameters.AddWithValue("?", ticketsToBook);
                    updateCmd.Parameters.AddWithValue("?", eventName);
                    int rowsAffected = updateCmd.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        throw new Exception("Booking failed while updating tickets.");
                    }
                }

                // Insert booking record
                string insertBooking = @"INSERT INTO Bookings (user_id, EventName, BookingDate, TicketCount) 
                                         VALUES (?, ?, ?, ?)";
                using (OleDbCommand insertCmd = new OleDbCommand(insertBooking, conn, transaction))
                {
                    insertCmd.Parameters.AddWithValue("?", userId);
                    insertCmd.Parameters.AddWithValue("?", eventName);
                    insertCmd.Parameters.AddWithValue("?", DateTime.Now);
                    insertCmd.Parameters.AddWithValue("?", ticketsToBook);

                    insertCmd.ExecuteNonQuery();
                }

                transaction.Commit();

                lblMessage.CssClass = "message";
                lblMessage.Text = "Booking successful!";
                LoadEventDetails(eventName);  // Refresh details to show updated tickets
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                lblMessage.CssClass = "error";
                lblMessage.Text = "Error while booking: " + ex.Message;
            }
        }
    }
}


}
