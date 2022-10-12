using DMS.Tools;
using MWSFramework;
using System;

namespace DebtChecking
{
    public partial class ScreenReport : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string messages = "";
            if (!IsPostBack)
            {
                MWReport.ReportInit(reporttab, Request.QueryString["grp"]?.ToString(), conn, ref messages);
                if (!String.IsNullOrEmpty(messages))
                {
                    MyPage.popMessage(this.Page, messages);
                }
            }
        }
    }
}