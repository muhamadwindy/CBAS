using MWSFramework;
using System;

namespace DebtChecking.Report
{
    public partial class Report : DataPage
    {
        private static string strSQL = "";
        private static string title = "";
        private static string idrep = "";
        private string messages = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                idrep = Request.QueryString["id"]?.ToString();
                MWReport.gridInit(ASPxGridView1, tblFilter, idrep, ref title, ref strSQL, conn, ref messages);
                if (!String.IsNullOrEmpty(messages))
                {
                    mainPanel.JSProperties["cp_alert"] = messages;
                }
                return;
            }
             
        }

        protected void mainPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter.ToString().StartsWith("remsession:"))
            {
                paramSearch.Value = "";
            }
            if (e.Parameter.ToString().StartsWith("search:"))
            {
                paramSearch.Value = e.Parameter.Substring(7);
                bindData();
            }
        }

        private void bindData()
        {
            MWReport.bindGrid(ASPxGridView1, idrep, paramSearch.Value, strSQL, conn, ref messages);
            if (!String.IsNullOrEmpty(messages))
            {
                mainPanel.JSProperties["cp_alert"] = messages;
            }
        }

        protected void ASPxGridView1_BeforeExport(object sender, DevExpress.Web.ASPxGridBeforeExportEventArgs e)
        {
            bindData();
        }

        protected void ASPxGridView1_PageIndexChanged(object sender, EventArgs e)
        {
            bindData();
        }
    }
}