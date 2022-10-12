using System;

namespace DebtChecking.Report
{
    public partial class ReportSet : DataPage
    {
        #region static vars

        private static string Q_PARAMLIST = "SELECT * FROM VW_REPORTSET WHERE SETID=@1 ORDER BY PV_DESC";

        #endregion static vars

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dataView.ColumnCount = 5;
                if (Request.QueryString["col"] != null)
                    try
                    {
                        dataView.ColumnCount = int.Parse(Request.QueryString["col"]);
                    }
                    catch { }

                if (Session["BackURL"] != null)
                    Session.Remove("BackURL");
                Session.Add("BackURL", Request.RawUrl);
            }
        }

        private void binddata()
        {
            object[] par = new object[] { Request.QueryString["SETID"] };
            dataView.DataSource = conn.GetDataTable(Q_PARAMLIST, par, dbtimeout);
            dataView.DataBind();
        }

        protected void dataView_Load(object sender, EventArgs e)
        {
            binddata();
        }
    }
}