using System;

namespace DebtChecking
{
    public partial class Dashboard : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                api_url.Value = conn.GetDataTable("EXEC Getdashboardurl", null, dbtimeout).Rows?[0][0].ToString();
            }
        }
    }
}