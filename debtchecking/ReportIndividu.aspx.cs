using System;
using System.Data;
using System.Web.UI.WebControls;

namespace DebtChecking
{
    public partial class ReportIndividu : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindGridPengajuanRequest("xx|za|za");
                bindGridRingkasanHasilSLIK("xx|x|xxx|xxx");
                bindGridDebitur("xx|x|xxx|xxx");
                bindGridFasilitas("xx|x|ss|xxx|xxx");
                bindGridAgunan("xx|x|ss|xzxz|xzxz");
                bindGridPenjamin("xx|x|ss|xsq|xasa");
            }
        }

        private void bindGridPengajuanRequest(string param)
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

            DataTable dt = conn.GetDataTable("exec Getreportpengajuanrequest" + sqlparamIndex, par, dbtimeout);
            GridPengajuanRequest.DataSource = dt;
            GridPengajuanRequest.DataBind();
            GridPengajuanRequest.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        private void bindGridRingkasanHasilSLIK(string param)
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

            DataTable dt = conn.GetDataTable("exec Getreportringkasanhasilslik" + sqlparamIndex, par, dbtimeout);
            GridRingkasanHasilSLIK.DataSource = dt;
            GridRingkasanHasilSLIK.DataBind();
            GridRingkasanHasilSLIK.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        private void bindGridDebitur(string param)
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

            DataTable dt = conn.GetDataTable("exec GetreportDebitur" + sqlparamIndex, par, dbtimeout);
            GridDebitur.DataSource = dt;
            GridDebitur.DataBind();
            GridDebitur.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        private void bindGridFasilitas(string param)
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

            DataTable dt = conn.GetDataTable("exec GetreportFasilitas" + sqlparamIndex, par, dbtimeout);
            GridFasilitas.DataSource = dt;
            GridFasilitas.DataBind();
            GridFasilitas.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        private void bindGridAgunan(string param)
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

            DataTable dt = conn.GetDataTable("exec GetreportAgunan" + sqlparamIndex, par, dbtimeout);
            GridAgunan.DataSource = dt;
            GridAgunan.DataBind();
            GridAgunan.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        private void bindGridPenjamin(string param)
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

            DataTable dt = conn.GetDataTable("exec GetreportPenjamin" + sqlparamIndex, par, dbtimeout);
            GridPenjamin.DataSource = dt;
            GridPenjamin.DataBind();
            GridPenjamin.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void PanelPengajuanRequest_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            var param = e.Parameter.Substring(2);
            if (e.Parameter.ToString().StartsWith("s:"))
            {
                bindGridPengajuanRequest(param);
            }
        }

        protected void GridPengajuanRequest_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            FormatHeader(e);
        }

        protected void PanelRingkasanHasilSLIK_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            var param = e.Parameter.Substring(2);
            if (e.Parameter.ToString().StartsWith("s:"))
            {
                bindGridRingkasanHasilSLIK(param);
            }
        }

        protected void GridRingkasanHasilSLIK_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            FormatHeader(e);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            FormatHeader(e);
        }

        protected void PanelDebitur_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            var param = e.Parameter.Substring(2);
            if (e.Parameter.ToString().StartsWith("s:"))
            {
                bindGridDebitur(param);
            }
        }

        protected void PanelFasilitas_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            var param = e.Parameter.Substring(2);
            if (e.Parameter.ToString().StartsWith("s:"))
            {
                bindGridFasilitas(param);
            }
        }

        protected void GridFasilitas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            FormatHeader(e);
        }

        protected void PanelAgunan_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            var param = e.Parameter.Substring(2);
            if (e.Parameter.ToString().StartsWith("s:"))
            {
                bindGridAgunan(param);
            }
        }

        protected void GridAgunan_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            FormatHeader(e);
        }

        protected void PanelPenjamin_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            var param = e.Parameter.Substring(2);
            if (e.Parameter.ToString().StartsWith("s:"))
            {
                bindGridPenjamin(param);
            }
        }

        protected void GridPenjamin_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            FormatHeader(e);
        }

        private void FormatHeader(GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    e.Row.Cells[i].Text = e.Row.Cells[i].Text.Replace("_", " ");
                }
            }
        }
    }
}