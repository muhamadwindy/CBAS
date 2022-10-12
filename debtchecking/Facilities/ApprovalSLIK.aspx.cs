using DevExpress.Web;
using MWSFramework;
using System;
using System.Data;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace DebtChecking.Facilities
{
    public partial class ApprovalSLIK : DataPage
    {
        #region retreive & save

        private void retrieve_data()
        {
            DataTable dt = conn.GetDataTable("select * from vw_apprequest where requestid = @1",
                new object[] { Request.QueryString["requestid"] }, dbtimeout);
            staticFramework.retrieve(dt, requestid);
            staticFramework.retrieve(dt, inputby);
            staticFramework.retrieve(dt, reqdate);
            staticFramework.retrieve(dt, productid);
            staticFramework.retrieve(dt, productdesc);
            staticFramework.retrieve(dt, purposedesc);
            staticFramework.retrieve(dt, remark);
            staticFramework.retrieve(dt, branchname);
            staticFramework.retrieve(dt, cust_type);
            staticFramework.retrieve(dt, cust_name);
            staticFramework.retrieve(dt, dob);
            staticFramework.retrieve(dt, ktp);
            staticFramework.retrieve(dt, pob);
            staticFramework.retrieve(dt, npwp);
            staticFramework.retrieve(dt, homeaddress);
            staticFramework.retrieve(dt, phonenumber);

            if (remark.Text == "")
            {
                remark.Text = "Belum ada hasil";
            }

            if (cust_type.Text == "IND")
            {
                staticFramework.retrieve(dt, gender_desc);
                staticFramework.retrieve(dt, mother_name);
            }
            else
            {
                tr_gender.Visible = false;
                tr_mother_name.Visible = false;
            }


            #region Info Produk

            string queryDealer = "Select DealerCode, DealerName from dbo.RfDealer where Active = 1";
            if (productdesc.Text.Contains("used pv"))
            {
                queryDealer += " and DealerName like '%used car%'";
            }
            staticFramework.reff(DealerCode, queryDealer, null, conn);


            staticFramework.reff(SalesPerson, "select SalesId, SalesName FROM RfSalesPerson where Active = 1", null, conn);
            staticFramework.reff(Brand, "select BrandId, BrandName from dbo.rfbrandmanufacturer where Active = 1", null, conn);
            staticFramework.reff(VehicleYear, "select VehicleYearCode, VehicleYear from dbo.RfVehicleYear where Active = 1", null, conn);
            staticFramework.reff(LoanTerm, "select Tenor, Tenor from dbo.RfTenor", null, conn);
             
            string vehicleYear = VehicleYear.SelectedValue; 
            DataTable dtLoan = conn.GetDataTable("select * from dbo.AppLoanInfo where RequestId=@1",
                new object[] { Request.QueryString["requestid"] }, dbtimeout);
            staticFramework.retrieve(dtLoan, DealerCode);
            staticFramework.retrieve(dtLoan, "DealerCode", h_DealerCode);
            staticFramework.retrieve(dtLoan, "SalesId", SalesPerson);
            staticFramework.retrieve(dtLoan, "SalesId", h_SalesPerson);
            staticFramework.retrieve(dtLoan, "BrandId", Brand);
            staticFramework.retrieve(dtLoan, "BrandId", h_Brand);


            object[] par = new object[] { h_Brand.Value };
            staticFramework.reff(Model, "select ModelId as DATA_CODE, ModelName AS DATA_DESC from dbo.RfModel m where m.BrandId = @1 and Active = 1", par, conn);
            loadTenor();

            staticFramework.retrieve(dtLoan, "ModelId", Model);
            staticFramework.retrieve(dtLoan, "ModelId", h_Model);

            staticFramework.reff(Varian, "select VarianId, VarianName from dbo.RfVarian where ModelId = @1 and Active = 1", new object[] { h_Model.Value }, conn);



            staticFramework.retrieve(dtLoan, "VarianId", Varian);
            staticFramework.retrieve(dtLoan, "VarianId", h_Varian);
            staticFramework.retrieve(dtLoan, "VehicleYearCode", VehicleYear);
            staticFramework.retrieve(dtLoan, "VehicleYearCode", h_VehicleYear);


            string productId = productid.Value;
            string vcar = VehicleYear.SelectedValue;
            staticFramework.reff(NoOfUnit, "exec dbo.UspNoOfUnit", new object[] { productId, vcar }, conn);


            staticFramework.retrieve(dtLoan, "NoOfUnitId", NoOfUnit);
            staticFramework.retrieve(dtLoan, "NoOfUnitId", h_NoOfUnit);
            staticFramework.retrieve(dtLoan, "Otr", OTR);
            staticFramework.retrieve(dtLoan, "DP", DP);
            loadTenor();
            staticFramework.retrieve(dtLoan, "LoanTerm", LoanTerm);
            staticFramework.retrieve(dtLoan, "InterestRate", InterestRate);
            #endregion
        }

        private void gridbind_suppl()
        {
            DataTable dt = conn.GetDataTable("select *, rel_desc as relation from apprequestsupp left join rfrelationbic " +
                "on rel_code = status_app where requestid = @1 order by seq",
                new object[] { requestid.Text }, dbtimeout);
            GridViewSuppl.DataSource = dt;
            GridViewSuppl.DataBind();
        }

        protected void gridbindnotes()
        {
            DataTable dt = conn.GetDataTable("select * from vw_apprequesttrack where requestid = @1 order by seq desc",
                new object[] { Request.QueryString["requestid"] }, dbtimeout);
            if (dt.Rows.Count > 0)
            {
                GRID_NOTES.DataSource = dt;
                GRID_NOTES.DataBind();
            }
            else { GRID_NOTES.Visible = false; }
        }

        private void savedata()
        {
            //
        }

        #endregion retreive & save

        #region Additional Function

        private DataSet ds = null;

        public string FormatedValue(object value)
        {
            string FormatType = null;
            if (value is Int32 || value is Int64 || value is float || value is double || value is decimal)
                FormatType = "n0";
            if (value is DateTime)
                FormatType = "dd MMM yyyy HH:mm:ss";
            return FormatedValue(value, FormatType);
        }

        public string FormatedValue(object value, string FormatType)
        {
            if (value == DBNull.Value)
                value = "";
            if (FormatType != null)
            {
                if (value is Int32)
                    value = ((Int32)value).ToString(FormatType);
                else if (value is Int64)
                    value = ((Int64)value).ToString(FormatType);
                else if (value is float)
                    value = ((float)value).ToString(FormatType);
                else if (value is double)
                    value = ((double)value).ToString(FormatType);
                else if (value is decimal)
                    value = ((decimal)value).ToString(FormatType);
                else if (value is DateTime)
                    value = ((DateTime)value).ToString(FormatType);
            }
            return value.ToString();
        }

        public string DS(int tbl, string FieldName)
        {
            try
            {
                object value = ds.Tables[tbl].Rows[0][FieldName];
                return FormatedValue(value);
            }
            catch
            {
                return "";
            }
        }

        public string DS(int tbl, string FieldName, string FormatType)
        {
            try
            {
                if (ds.Tables[tbl].Rows.Count == 0)
                    return "";
                object value = ds.Tables[tbl].Rows[0][FieldName];
                return FormatedValue(value, FormatType);
            }
            catch
            {
                return "";
            }
        }

        public string DS_SUM(int tbl, string FieldName, string sumtype)
        {
            return DS_SUM(tbl, FieldName, sumtype, null);
        }

        public string DS_SUM(int tbl, string FieldName, string sumtype, string FormatType)
        {
            DataTable dt = ds.Tables[tbl];

            double value = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                switch (sumtype)
                {
                    case "SUM":
                        if (dt.Rows[i][FieldName] != DBNull.Value)
                            value += double.Parse(dt.Rows[i][FieldName].ToString());
                        break;

                    case "CNT":
                        value += 1;
                        break;

                    case "AVG":
                        if (dt.Rows[i][FieldName] != DBNull.Value)
                            value += Convert.ToSingle(dt.Rows[i][FieldName]);
                        break;
                }
            }
            if (sumtype == "AVG" && value != 0)
                value = value / dt.Rows.Count;

            if (value != 0)
            {
                if (FormatType == null)
                    return FormatedValue(value);
                else
                    return FormatedValue(value, FormatType);
            }
            else return "";
        }

        #endregion Additional Function

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridUploadFoto();

                if (Request.QueryString["reqstatus"]?.ToString() == "MACR" && GROUPID == "CR"
                    )
                {
                    btn_apprv.Value = "Assign";
                    btn_back.Visible = false;
                    btn_reject.Visible = false;
                    btn_del.Visible = true;
                }
                else
                {
                    btn_apprv.Value = "Approve";
                    btn_back.Visible = true;
                    btn_reject.Visible = true;
                    btn_del.Visible = false;
                }
                retrieve_data();
                gridbind_suppl();
                gridbindnotes();
            }
        }

        protected void GridFileUpload_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridFileUpload.PageIndex = e.NewPageIndex;
        }

        protected void GridFileUpload_PageIndexChanged(object sender, EventArgs e)
        {
            BindGridUploadFoto();
        }

        protected void GridFileUpload_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
                return;

            DataRowView dataItem = (DataRowView)e.Row.DataItem;

            HtmlAnchor lnkDownload = (HtmlAnchor)e.Row.FindControl("lnkDownload");
            if (string.IsNullOrEmpty(lnkDownload.Attributes["data-uploadby"]))
            {
                lnkDownload.Visible = false;
            }
            else
            {
                lnkDownload.Visible = true;
            }

            HtmlInputCheckBox cbUploaded = (HtmlInputCheckBox)e.Row.FindControl("cbUPLOADED");
            cbUploaded.Disabled = true;

            if (cbUploaded.Attributes["data-uploaded"].ToLower() == "true")
            {
                cbUploaded.Checked = true;
            }
            else
            {
                cbUploaded.Checked = false;
            }
        }

        protected void gridPanel_Callback(object source, CallbackEventArgsBase e)
        {
            if (e.Parameter.ToString().StartsWith("r:"))
                DownloadFile(e.Parameter.Substring(2));
            else if (e.Parameter.ToString().StartsWith("u:"))
                gridPanel.JSProperties["cp_new"] = e.Parameter.Substring(2);
            BindGridUploadFoto();
        }

        protected void DownloadFile(string id)
        {
            try
            {
                string directory = "";

                object[] par = new object[] { Request.QueryString["REQUESTID"], id };

                conn.ExecReader("SELECT * FROM VW_APP_UPLOAD_DOC WHERE REQUESTID = @1 AND DOC_ID = @2", par, dbtimeout);

                if (conn.hasRow())
                {
                    directory = conn.GetFieldValue("DIRECTORY");
                }

                gridPanel.JSProperties["cp_url"] = directory;
            }
            catch (Exception ex)
            {
                gridPanel.JSProperties["cp_alert"] = ex.Message.IndexOf("Last Query:") <= 0 ? ex.Message : ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
            }
        }

        private void BindGridUploadFoto()
        {
            object[] par = new object[] { Request.QueryString["requestid"], USERID };

            DataTable dt = conn.GetDataTable("EXEC SP_VW_APP_UPLOAD_DOC @1,@2 ", par, dbtimeout);
            DataView dv = new DataView(dt);

            if (Request.QueryString["requestid"] != null && Request.QueryString["requestid"].ToString().Contains("PMP"))
            {
                dv.RowFilter = "DOC_OTHER = '" + Request.QueryString["data"].ToString() + "'";
            }

            GridFileUpload.DataSource = dv;
            GridFileUpload.DataBind();
        }

        #region callback

        protected void mainPanel_Callback(object source, CallbackEventArgsBase e)
        {
            try
            {
                string redirectTo = "../ScreenMenu.aspx?sm=" + Request.QueryString["reqstatus"].ToString() + "&passurl&mntitle=" +
                    (Request.QueryString["reqstatus"]?.ToString() == "MACR" ? "Manual Assignment" : "Approval") + "&li=L|"
                    + Request.QueryString["reqstatus"]?.ToString();

                if (e.Parameter == "a")
                {
                    string sql = "exec sp_update_request @1,@2,@3,@4";
                    object[] par = new object[] { };

                    par = new object[] { requestid.Text, Request.QueryString["reqstatus"]?.ToString() == "MACR" ? "MSA" : "APV", Session["UserID"], null };

                    //NameValueCollection Keys = new NameValueCollection();
                    //NameValueCollection Fields = new NameValueCollection();
                    //Fields["aprvbm_date"] = "getdate()";
                    //staticFramework.saveNVC(Keys, requestid);
                    //staticFramework.saveNVC(Fields, "aprvbm_by", USERID);
                    //staticFramework.save(Fields, Keys, "apprequest", conn);

                    conn.ExecNonQuery(sql, par, dbtimeout);
                    mainPanel.JSProperties["cp_alert"] = "Data permintaan SLIK checking berhasil di" + btn_apprv.Value.ToLower();
                    mainPanel.JSProperties["cp_target"] = "mainFramex";
                    mainPanel.JSProperties["cp_redirect"] = redirectTo;
                }
                else if (e.Parameter == "d")
                {
                    object[] param = new object[] { Request.QueryString["requestid"] };
                    //delete file on storage first
                    DataTable dt = conn.GetDataTable("select top 1 DIRECTORY from VW_APP_UPLOAD_DOC where REQUESTID = @1 ", param, dbtimeout);

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string fullpath = "";
                        fullpath = dt.Rows[i][0].ToString();
                        string path = Server.MapPath(fullpath);
                        FileInfo file = new FileInfo(path);
                        if (file.Exists)//check file exsit or not
                        {
                            file.Delete();
                        }
                    }

                    //delete record on db
                    conn.ExecNonQuery("DELETE FROM APP_UPLOAD_DOC WHERE REQUESTID = @1 ", param, dbtimeout);

                    conn.ExecNonQuery("DELETE FROM apprequestsupp WHERE requestid=@1", param, dbtimeout);
                    conn.ExecNonQuery("DELETE FROM apprequest WHERE requestid=@1", param, dbtimeout);
                    mainPanel.JSProperties["cp_alert"] = "Data permintaan SLIK checking berhasil dihapus.";
                    mainPanel.JSProperties["cp_target"] = "mainFramex";
                    mainPanel.JSProperties["cp_redirect"] = redirectTo;
                }
            }
            catch (Exception ex)
            {
                string errmsg = "";
                if (ex.Message.IndexOf("Last Query:") > 0)
                    errmsg = ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
                else
                    errmsg = ex.Message;
                mainPanel.JSProperties["cp_alert"] = errmsg;
            }
        }

        protected void PanelSID_Callback(object source, CallbackEventArgsBase e)
        {
            try
            {
                if (e.Parameter == "r")
                    btn_confirm.Attributes["onclick"] = "callback(PanelSID,'reject')";
                else if (e.Parameter == "v")
                    btn_confirm.Attributes["onclick"] = "callback(PanelSID,'reverse')";
                if (e.Parameter == "reject")
                {
                    string sql = "exec sp_update_request @1,@2,@3,@4";
                    object[] par = new object[] { requestid.Text, "RJC", Session["UserID"], comment.Text };
                    conn.ExecNonQuery(sql, par, dbtimeout);
                    PanelSID.JSProperties["cp_alert"] = "Data permintaan SLIK checking berhasil direject.";
                    PanelSID.JSProperties["cp_target"] = "mainFramex";
                    PanelSID.JSProperties["cp_redirect"] = "../ScreenMenu.aspx?sm=APVBM&passurl&mntitle=Approval Branch Manager&li=L|APVBM";
                }
                else if (e.Parameter == "reverse")
                {
                    string sql = "exec sp_update_request @1,@2,@3,@4";
                    object[] par = new object[] { requestid.Text, "RVS", Session["UserID"], comment.Text };
                    conn.ExecNonQuery(sql, par, dbtimeout);
                    PanelSID.JSProperties["cp_alert"] = "Data permintaan SLIK checking berhasil direverse.";
                    PanelSID.JSProperties["cp_target"] = "mainFramex";
                    PanelSID.JSProperties["cp_redirect"] = "../ScreenMenu.aspx?sm=APVBM&passurl&mntitle=Approval Branch Manager&li=L|APVBM";
                }
            }
            catch (Exception ex)
            {
                string errmsg = "";
                if (ex.Message.IndexOf("Last Query:") > 0)
                    errmsg = ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
                else
                    errmsg = ex.Message;
                PanelSID.JSProperties["cp_alert"] = errmsg;
            }
        }

        protected void GridViewSuppl_Load(object sender, EventArgs e)
        {
            gridbind_suppl();
            if (Request.QueryString["readonly"] != null)
                ModuleSupport.DisableControls(this, allowViewState);
        }

        #endregion callback




        //windy

        protected void panelDealer_Callback(object sender, CallbackEventArgsBase e)
        {

            string queryDealer = "Select DealerCode, DealerName from dbo.RfDealer where Active = 1";
            if (productdesc.Text.Contains("used pv"))
            {
                queryDealer += " and DealerName like '%used car%'";
            }
            staticFramework.reff(DealerCode, queryDealer, null, conn);

        }
        protected void panelModel_Callback(object sender, CallbackEventArgsBase e)
        {

            object[] par = new object[] { h_Brand.Value };
            staticFramework.reff(Model, "select ModelId as DATA_CODE, ModelName AS DATA_DESC from dbo.RfModel m where m.BrandId = @1 and Active = 1", par, conn);
        }



        protected void panelVarian_Callback(object sender, CallbackEventArgsBase e)
        {
            staticFramework.reff(Varian, "select VarianId, VarianName from dbo.RfVarian where ModelId = @1 and Active = 1", new object[] { h_Model.Value }, conn);

        }

        protected void panelLoanTerm_Callback(object sender, CallbackEventArgsBase e)
        {
            loadTenor();
        }
        private void loadTenor()
        {
            string query = "exec dbo.UspGetMaxTenor @1, @2, @3";
            int maxTenor = 0;
            object[] par = new object[] { productdesc, h_Brand.Value, h_VehicleYear.Value };
            conn.ExecReader(query, par, 600);
            if (conn.hasRow())
            {
                maxTenor = Convert.ToInt32(conn.GetFieldValue(0));
            }
            query = "select Tenor, cast(Tenor as varchar(20)) TenorText from dbo.RfTenor where Tenor <= @1 and Active = 1";

            staticFramework.reff(LoanTerm, query, new object[] { maxTenor }, conn);

        }

    }
}