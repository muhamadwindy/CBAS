using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DebtChecking.Report
{
    public partial class RequestLog : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                bindGridRequestLog("NULL|NULL|NULL");
            }
        }

        private void bindGridRequestLog(string param)
        {

            var paramSQL = param.Replace(" - ", "|").Split('|');
            object[] par = new object[paramSQL.Length];
            string sqlparamIndex = " ";
            for (int i = 0; i < paramSQL.Length; i++)
            {
                par[i] = paramSQL[i];
                sqlparamIndex += ("@" + (i + 1) + ",");
            }

            sqlparamIndex = sqlparamIndex.Remove(sqlparamIndex.Length - 1, 1);

            DataTable dt = conn.GetDataTable("exec Reportrequestlog" + sqlparamIndex, par, dbtimeout);
            GridReport.DataSource = dt;
            GridReport.DataBind();
            GridReport.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void PanelPengajuanRequest_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {

            var param = e.Parameter.Substring(2);
            if (e.Parameter.ToString().StartsWith("s:"))
            {
                bindGridRequestLog(param);
            }
        }
    }
}