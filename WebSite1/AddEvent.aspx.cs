using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class AddEvent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindEventsGrid();
        }
    }

    protected void backHome_Click(object sender, EventArgs e)
    {
        // Redirect to your home page (adjust the URL as needed)
        Response.Redirect("Home.aspx");
    }

    private void BindEventsGrid()
    {
        string connStr = ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;
        using (OleDbConnection conn = new OleDbConnection(connStr))
        {
            string query = "SELECT EventName, Category, Location, Price, EventDate, [Tickets count] FROM Events ORDER BY EventDate DESC";
            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                using (OleDbDataAdapter adapter = new OleDbDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    gvEvents.DataSource = dt;
                    gvEvents.DataBind();
                }
            }
        }
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        txtName.Text = "";
        txtCategory.Text = "";
        txtLocation.Text = "";
        txtPrice.Text = "";
        txtDate.Text = "";
        txtTickets.Text = "";
        lblMessage.Text = "";
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        string name = txtName.Text.Trim();
        string category = txtCategory.Text.Trim();
        string location = txtLocation.Text.Trim();
        string price = txtPrice.Text.Trim();
        string date = txtDate.Text.Trim();
        string tickets = txtTickets.Text.Trim();

        string connStr = ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;

        using (OleDbConnection conn = new OleDbConnection(connStr))
        {
            try
            {
                conn.Open();

                // Parse the date once using dd/MM/yyyy format
                DateTime eventDate = DateTime.ParseExact(date, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                // 1. Check if the event already exists (Name + Date)
                string checkQuery = @"SELECT COUNT(*) FROM Events 
                                      WHERE EventName = ? AND EventDate = ?";
                using (OleDbCommand checkCmd = new OleDbCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("?", name);
                    checkCmd.Parameters.AddWithValue("?", eventDate);

                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        lblMessage.CssClass = "error";
                        lblMessage.Text = "This event already exists!";
                        return;
                    }
                }

                // 2. Insert only if not duplicate
                string insertQuery = @"INSERT INTO Events ([EventName], [Category], [Location], [Price], [EventDate], [Tickets count])
                                   VALUES (?, ?, ?, ?, ?, ?)";

                using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("?", name);
                    cmd.Parameters.AddWithValue("?", category);
                    cmd.Parameters.AddWithValue("?", location);
                    cmd.Parameters.AddWithValue("?", decimal.Parse(price));
                    cmd.Parameters.AddWithValue("?", eventDate);
                    cmd.Parameters.AddWithValue("?", int.Parse(tickets));

                    cmd.ExecuteNonQuery();

                    lblMessage.CssClass = "message";
                    lblMessage.Text = "Event added successfully!";
                    BindEventsGrid();


                    // Clear input fields
                    txtName.Text = "";
                    txtCategory.Text = "";
                    txtLocation.Text = "";
                    txtPrice.Text = "";
                    txtDate.Text = "";
                    txtTickets.Text = "";

            
                }
            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "error";
                lblMessage.Text = "Error: " + ex.Message;
            }
        }
    }
}
