using System;

namespace DebtChecking.Facilities
{
    public partial class InqStatus : DataPage   
    {
        #region static vars

        private static string Q_TRCURR = "SELECT * FROM VW_APPFLAG WHERE AP_REGNO = @1 ";
        private static string Q_TRHIST = "SELECT * FROM VW_TRACKHISTORY WHERE AP_REGNO = @1 ORDER BY TR_DATE DESC";

        #endregion static vars

        #region binddata

        protected void gridbindtr()
        {
            object[] param = new object[] { Request.QueryString["regno"] };
            gridTr.DataSource = conn.GetDataTable(Q_TRCURR, param, dbtimeout);
            gridTr.DataBind();
        }

        protected void gridbindtrhist()
        {
            object[] param = new object[] { Request.QueryString["regno"] };
            gridTrHist.DataSource = conn.GetDataTable(Q_TRHIST, param, dbtimeout);
            gridTrHist.DataBind();
        }

        #endregion binddata

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void gridTr_Load(object sender, EventArgs e)
        {
            gridbindtr();
        }

        protected void gridTrHist_Load(object sender, EventArgs e)
        {
            gridbindtrhist();
        }
    }
}