using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

public partial class SearchEvent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindEvents(); // Load all events initially
        }
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }


    private void BindEvents(string searchTerm = null)
    {
        string connStr = ConfigurationManager.ConnectionStrings["TicketoConn"].ConnectionString;
        using (OleDbConnection conn = new OleDbConnection(connStr))
        {
            conn.Open();
            string query = "SELECT [EventName], [Category], [Location], [Price], [EventDate], [Tickets count] FROM Events";
            if (!string.IsNullOrEmpty(searchTerm))
            {
                query += " WHERE [EventName] LIKE ?";
            }
            query += " ORDER BY [EventDate] DESC";

            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                if (!string.IsNullOrEmpty(searchTerm))
                {
                    cmd.Parameters.AddWithValue("?", "%" + searchTerm + "%");
                }

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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchTerm = txtSearch.Text.Trim();
        BindEvents(searchTerm);
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        BindEvents();
    }

    protected void gvEvents_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "BookNow")
        {
            string eventName = e.CommandArgument.ToString();
            Response.Redirect("BookNow.aspx?event=" + Server.UrlEncode(eventName));
        }
    }
}
