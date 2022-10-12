using DMS.Tools;
using Microsoft.Office.Interop.Excel;
using MWSFramework;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using OfficeOpenXml;
using DataTable = System.Data.DataTable;
using System.Configuration;


namespace DebtChecking.Facilities
{
    public partial class uploadrequestslikskbf : DataPage
    {
        string reqstatus = "";
        string upliner = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //tbl_error.Visible = false;
                string urlLogin = DebtChecking.CommonForm.CustomFunction.CheckSession();
                if (string.IsNullOrEmpty(urlLogin))
                {
                    string queryCheck = "select count(1) from dbo.ErrorUploadSLIKRequest where UserId=@1";
                    conn.ExecReader(queryCheck, new object[] { USERID }, dbtimeout);
                    if (conn.hasRow())
                    {
                        int total = Convert.ToInt32(conn.GetFieldValue(0));
                        if (total > 1)
                        {
                            tbl_error.Attributes.Add("style", "");
                            BindGridError();
                        }
                        else
                        {
                            tbl_error.Attributes.Add("style", "display:none");
                        }
                    }
                }
                else
                {
                    Response.Redirect(urlLogin);
                }
            }
        }


        //custom
        private void ProcessExcel(string path)
        {
            //ApplicationClass app = new ApplicationClass();
            //Workbook book = null;
            //Range range = null;
            string tempreqstatus = "";
            string upliner = "";
            string upliner2 = "";
            string upliner3 = "";

            #region Create Datatable Error       
            DataTable dtError = new DataTable();
            //dtError.Columns.Add("row", typeof(string));
            dtError.Columns.Add("cust_name", typeof(string));
            dtError.Columns.Add("sheet", typeof(string));
            //dtError.Columns.Add("checkingslik", typeof(string));
            dtError.Columns.Add("keterangan", typeof(string));
            #endregion

            #region Create Datatable Insert       
            DataTable table = new DataTable();
            table.Columns.Add("no", typeof(string));
            table.Columns.Add("inputdate", typeof(string));
            table.Columns.Add("inputby", typeof(string));
            table.Columns.Add("reqstatus", typeof(string));
            table.Columns.Add("requestid", typeof(string));
            table.Columns.Add("productid", typeof(string));
            table.Columns.Add("branchid", typeof(string));
            table.Columns.Add("purpose", typeof(string));
            table.Columns.Add("cust_name", typeof(string));
            table.Columns.Add("dob", typeof(DateTime));
            table.Columns.Add("ktp", typeof(string));
            table.Columns.Add("cust_type", typeof(string));
            table.Columns.Add("npwp", typeof(string));
            //table.Columns.Add("status_bpkb", typeof(string));
            //table.Columns.Add("nama_bpkb", typeof(string));
            table.Columns.Add("pob", typeof(string));
            table.Columns.Add("gender", typeof(string));
            //table.Columns.Add("mother_name", typeof(string));
            //table.Columns.Add("homeaddress", typeof(string));
            //table.Columns.Add("phonenumber", typeof(string));
            table.Columns.Add("cid", typeof(string));
            table.Columns.Add("curr_holder", typeof(string));
            //table.Columns.Add("channel_id", typeof(string));
            //table.Columns.Add("channel_reff_id", typeof(string));
            //table.Columns.Add("curr_holder_alt1", typeof(string));
            //table.Columns.Add("curr_holder_alt2", typeof(string));
            #endregion            


            try
            {
                DataTable dt = conn.GetDataTable("select top 1 * from RFSTATUSUPLOAD", null, dbtimeout);
                if (dt.Rows.Count > 0)
                {
                    tempreqstatus = dt.Rows[0][0].ToString();
                }


                object[] param = new object[] { USERID };
                DataTable dtUpliner = conn.GetDataTable(" select  SU_UPLINER,SU_UPLINER2,SU_UPLINER3 from scalluser where USERID = @1", param, dbtimeout);
                if (dtUpliner.Rows.Count > 0)
                {
                    upliner = dtUpliner.Rows[0]["SU_UPLINER"].ToString();
                    upliner2 = dtUpliner.Rows[0]["SU_UPLINER2"].ToString();
                    upliner3 = dtUpliner.Rows[0]["SU_UPLINER3"].ToString();
                }


                // DataTable dtCusttype = conn.GetDataTable(" SELECT CUSTTYPE_CODE,CUSTTYPE_DESC,CORE_CODE FROM RFCUSTTYPE WHERE ACTIVE = 1", param, dbtimeout);


                #region Upload baru
                FileInfo fileInfo = new FileInfo(path);

                //if (fileInfo.Length <= Convert.ToInt32(ConfigurationSettings.AppSettings["MAXFILEUPLOAD"]))
                //{

                // If you are a commercial business and have
                // purchased commercial licenses use the static property
                // LicenseContext of the ExcelPackage class:
                //ExcelPackage.LicenseContext = LicenseContext.Commercial;

                // If you use EPPlus in a noncommercial context
                // according to the Polyform Noncommercial license:
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

                using (var package = new ExcelPackage(fileInfo))
                {
                    //ExcelPackage package = new ExcelPackage(fileInfo);

                    #region Sheet 1 (SLIK)
                    ExcelWorksheet worksheet = package.Workbook.Worksheets[0];

                    // get number of rows and columns in the sheet
                    int rows = worksheet.Dimension.Rows; // 20
                    int columns = worksheet.Dimension.Columns; // 7
                    if (rows > 1)
                    {



                        // loop through the worksheet rows and columns
                        for (int i = 1; i <= rows; i++)
                        {
                            if (i > 1)
                            {

                                try
                                {


                                    #region inisialisasi  
                                    string no = "";
                                    string inputdate = DateTime.Now.ToString();
                                    string inputby = USERID;
                                    string reqstatus = tempreqstatus;
                                    string requestid = "";
                                    string productid = "";
                                    string branchid = "";
                                    string purpose = "";
                                    string cust_name = "";
                                    DateTime? dob = null;
                                    string ktp = "";
                                    string cust_type = "";
                                    string npwp = "";
                                    //string status_bpkp = "";
                                    //string nama_bpkp = "";
                                    string pob = "";
                                    string gender = "";
                                    //string mother_name = "";
                                    //string homeaddress = "";
                                    //string phonenumber = "";
                                    string cid = "UPLOAD";
                                    string curr_holder = null;
                                    //string curr_holder_alt1 = upliner2;
                                    //string curr_holder_alt2 = upliner3;
                                    //string channel_id = "";
                                    //string channel_reff_id = "";
                                    string tempKetError = "";
                                    //string checkingSLIK = "";
                                    #endregion

                                    try
                                    {
                                        no = worksheet.Cells[i, 1].Value.ToString();
                                    }
                                    catch
                                    {
                                        no = "";
                                    }

                                    try
                                    {
                                        productid = worksheet.Cells[i, 2].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 2].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 2].Value.ToString().Trim();
                                    }
                                    catch
                                    {
                                        productid = "";
                                    }

                                    if (productid == "" || productid == "-")
                                    {
                                        productid = null;
                                    }

                                    try
                                    {
                                        branchid = Convert.ToInt32(worksheet.Cells[i, 3].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 3].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 3].Value.ToString()).ToString("0000").Trim();
                                    }
                                    catch
                                    {
                                        branchid = "";
                                    }

                                    if (branchid == "" || branchid == "-")
                                    {
                                        branchid = "0101";
                                    }



                                    try
                                    {
                                        purpose = worksheet.Cells[i, 4].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 4].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 4].Value.ToString().Trim();
                                    }
                                    catch
                                    {
                                        purpose = "";
                                    }

                                    if (purpose == "" || purpose == "-")
                                    {
                                        tempKetError = tempKetError + ",Tujuan SLIK Checking tidak boleh kosong";
                                    }



                                    //try
                                    //{
                                    //    string custtype_core = worksheet.Cells[i, 2].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 2].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 2].Value.ToString().Trim();
                                    //    if (dtCusttype.Rows.Count > 1)
                                    //    {
                                    //        if (custtype_core == dtCusttype.Rows[0][2].ToString())
                                    //        {
                                    //            cust_type = dtCusttype.Rows[0][0].ToString();
                                    //        }
                                    //        else
                                    //        {
                                    //            cust_type = dtCusttype.Rows[1][0].ToString();
                                    //        }
                                    //    }
                                    //}
                                    //catch
                                    //{
                                    //    cust_type = "";
                                    //}



                                    try
                                    {
                                        cust_type = worksheet.Cells[i, 8].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 8].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 8].Value.ToString().Trim();
                                    }
                                    catch
                                    {
                                        cust_type = "";
                                    }

                                    if (cust_type == "" || cust_type == "-")
                                    {
                                        tempKetError = tempKetError + ",Jenis Customer tidak boleh kosong";
                                    }


                                    if (purpose == "" && cust_type == "" && no == "")
                                    {
                                        break;
                                    }

                                    requestid = genreqid(cust_type);


                                    try
                                    {
                                        //cust_name = worksheet.Cells[i, 4].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 4].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 4].Value.ToString().Trim();
                                        cust_name = worksheet.Cells[i, 5].Value.ToString().Trim();
                                    }
                                    catch
                                    {
                                        cust_name = "";
                                    }
                                    if (cust_name == "" || cust_name == "-")
                                    {
                                        tempKetError = tempKetError + ",Nama Customer tidak boleh kosong";
                                    }


                                    try
                                    {
                                        DateTime temp_dob = Convert.ToDateTime(worksheet.Cells[i, 6].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 6].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 6].Value.ToString().Trim());
                                        dob = temp_dob;
                                    }
                                    catch
                                    {
                                        tempKetError = tempKetError + ",Tgl Lahir/Pendirian tidak boleh kosong / format salah";
                                    }




                                    if (cust_type.ToUpper() == "IND")
                                    {

                                        ///MANDATORY
                                        try
                                        {
                                            //ktp = worksheet.Cells[i, 6].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 6].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 6].Value.ToString().Trim();
                                            ktp = worksheet.Cells[i, 7].Value.ToString().Trim();
                                        }
                                        catch
                                        {
                                            ktp = "";
                                        }


                                        if (ktp == "" || ktp == "-")
                                        {
                                            tempKetError = tempKetError + ",Nomor KTP/AKTA tidak boleh kosong";
                                        }


                                        try
                                        {
                                            pob = worksheet.Cells[i, 10].Value.ToString().Trim();
                                        }
                                        catch
                                        {
                                            pob = null;
                                        }

                                        try
                                        {
                                            gender = worksheet.Cells[i, 11].Value.ToString().ToLower().Trim() == "perempuan" ? "F" : "M";
                                        }
                                        catch
                                        {
                                            gender = "";
                                        }

                                        if (gender == "" || gender == "-")
                                        {
                                            tempKetError = tempKetError + ",Jenis Kelamin tidak boleh kosong";
                                        }


                                        ///TIDAK MANDATORY
                                        try
                                        {
                                            //npwp = worksheet.Cells[i, 8].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 8].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 8].Value.ToString().Trim();
                                            npwp = worksheet.Cells[i, 9].Value.ToString().Trim();
                                        }
                                        catch
                                        {
                                            npwp = "-";
                                        }

                                        if (npwp == "-")
                                        {
                                            npwp = null;
                                        }

                                    }
                                    else if (cust_type.ToUpper() != "IND" && cust_type != "" && cust_type != "-")
                                    {

                                        ///MANDATORY
                                        try
                                        {
                                            //npwp = worksheet.Cells[i, 8].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 8].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 8].Value.ToString().Trim();
                                            npwp = worksheet.Cells[i, 9].Value.ToString().Trim();
                                        }
                                        catch
                                        {
                                            npwp = "";
                                        }

                                        if (npwp == "" || npwp == "-")
                                        {
                                            tempKetError = tempKetError + ",NPWP tidak boleh kosong";
                                        }


                                        try
                                        {
                                            pob = worksheet.Cells[i, 10].Value.ToString().Trim();
                                            //pob = null;
                                        }
                                        catch
                                        {
                                            pob = null;
                                        }



                                        ///TIDAK MANDATORY
                                        try
                                        {
                                            ktp = worksheet.Cells[i, 9].Value.ToString().Trim();//KETIKA BADAN USAHA, VALUE NPWP DI MASUKAN KE KTP
                                        }
                                        catch
                                        {
                                            ktp = "-";
                                        }


                                        if (ktp == "-")
                                        {
                                            ktp = null;
                                        }


                                        try
                                        {
                                            gender = worksheet.Cells[i, 11].Value.ToString().ToLower().Trim() == "perempuan" ? "F" : "M";
                                        }
                                        catch
                                        {
                                            gender = "-";
                                        }

                                        if (gender == "-")
                                        {
                                            gender = null;
                                        }

                                    }

                                    //status_bpkp = null;//worksheet.Cells[i, 9].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 9].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 9].Value.ToString().Trim();
                                    //nama_bpkp = null;//worksheet.Cells[i, 10].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 10].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 10].Value.ToString().Trim();


                                    //try
                                    //{
                                    //    mother_name = worksheet.Cells[i, 12].Value.ToString().Trim();
                                    //    //mother_name = null;
                                    //}
                                    //catch
                                    //{
                                    //    mother_name = "-";
                                    //}

                                    //if (mother_name == "-")
                                    //{
                                    //    mother_name = null;
                                    //}



                                    //if (mother_name == "" || mother_name == "-")
                                    //{
                                    //    tempKetError = tempKetError + ",Nama Ibu Kandung tidak boleh kosong";
                                    //}


                                    //try
                                    //{
                                    //    homeaddress = worksheet.Cells[i, 13].Value.ToString().Trim().Replace("'", "`");
                                    //    //homeaddress = null;
                                    //}
                                    //catch
                                    //{
                                    //    homeaddress = "";
                                    //}


                                    //try
                                    //{
                                    //    phonenumber = worksheet.Cells[i, 14].Value.ToString().Trim();
                                    //    //phonenumber = null;
                                    //}
                                    //catch
                                    //{
                                    //    phonenumber = "";
                                    //}

                                    //try
                                    //{
                                    //    //channel_id = worksheet.Cells[i, 14].Value.ToString().Trim();
                                    //    channel_id = worksheet.Cells[i, 15].Value.ToString().Contains(" - ") ? worksheet.Cells[i, 15].Value.ToString().Split('-')[0].Trim() : worksheet.Cells[i, 15].Value.ToString().Trim();

                                    //    //channel_id = null;
                                    //}
                                    //catch
                                    //{
                                    //    channel_id = "-";
                                    //}

                                    //if (channel_id == "" || channel_id == "-")
                                    //{
                                    //    tempKetError = tempKetError + ",Channel ID tidak boleh kosong";
                                    //}


                                    //try
                                    //{
                                    //    channel_reff_id = worksheet.Cells[i, 16].Value.ToString().Trim();
                                    //    //channel_id = null;
                                    //}
                                    //catch
                                    //{
                                    //    channel_reff_id = "-";
                                    //}

                                    //if (channel_reff_id == "" || channel_reff_id == "-")
                                    //{
                                    //    tempKetError = tempKetError + ",Channel Reff ID tidak boleh kosong";
                                    //}




                                    if (tempKetError != "" && no != "" && purpose != "")
                                    {
                                        dtError.Rows.Add(cust_name, "SLIK", tempKetError.Substring(1, tempKetError.Length - 1));
                                    }
                                    else if (tempKetError == "")
                                    {
                                        //checkingSLIK = checking_identitas(ktp);
                                        //if (checkingSLIK != "")
                                        //{
                                        //    dtError.Rows.Add(cust_name, "SLIK", checkingSLIK, "-");
                                        //}
                                        //else
                                        //{
                                        //table.Rows.Add(no, inputdate, inputby, reqstatus, requestid, productid, branchid, purpose, cust_name, dob, ktp, cust_type, npwp, status_bpkp, nama_bpkp, pob, gender, mother_name, homeaddress,
                                        //phonenumber, cid, curr_holder, channel_id, channel_reff_id);
                                        table.Rows.Add(no, inputdate, inputby, reqstatus, requestid, productid, branchid, purpose, cust_name, dob, ktp, cust_type, npwp, pob, gender, cid, curr_holder);
                                        //}


                                    }
                                }
                                catch (Exception e)
                                {


                                }
                            }
                        }

                    }
                    #endregion

                    if (dtError.Rows.Count == 0)
                    {
                        //bulkInsert(table);
                        insertToDB(table);
                        tbl_error.Visible = false;
                        MyPage.popMessage(this.Page, "Upload Sukses!");
                    }
                    else
                    {
                        tbl_error.Visible = true;
                        GRID_ERROR.DataSource = dtError;
                        GRID_ERROR.DataBind();
                        MyPage.popMessage(this.Page, "Upload Gagal!");
                    }
                }


                //}
                //else
                //{
                //    MyPage.popMessage(this.Page, "Upload Gagal, File Maksimal 4 Mb");
                //}
                #endregion

            }
            catch (Exception e)
            {
                MyPage.popMessage(this.Page, "Upload Gagal, Mohon Periksa Kembali Dokumen Anda");
            }
            finally
            {
                //range = null;
                //if (book != null)
                //    book.Close(false, Missing.Value, Missing.Value);
                //book = null;
                //if (app != null)
                //    app.Quit();
                File.Delete(path);
                //app = null;
            }
        }


        private string genreqid(string cust_type)
        {
            string reqid = "";
            object[] param = new object[] { cust_type };
            conn.ExecReader("exec sp_gen_requestid @1", param, dbtimeout);
            if (conn.hasRow()) reqid = conn.GetFieldValue(0);
            return reqid;
        }

        private string checking_identitas(string ktp)
        {
            string msg = "";
            object[] param = new object[] { ktp };
            conn.ExecReader("exec SP_REQUEST_CHECKING_UPLOAD @1", param, dbtimeout);
            if (conn.hasRow()) msg = conn.GetFieldValue(1);
            return msg;
        }

        protected void btn_upload_Click(object sender, EventArgs e)
        {
            if (fileUploadExcel.PostedFile != null)
            {
                string targetFolder = HttpContext.Current.Server.MapPath("~/Upload/RequestSLIK");
                string targetPath = Path.Combine(targetFolder, new Guid() + ".xlsx");
                fileUploadExcel.PostedFile.SaveAs(targetPath);


                ProcessExcel(targetPath);
            }

        }

        private void bulkInsert(DataTable table)
        {
            //creating object of SqlBulkCopy  
            SqlBulkCopy objbulk = new SqlBulkCopy(conn.ConnString);

            //assigning Destination table name  
            objbulk.DestinationTableName = "apprequest_pending";

            //Mapping Table column  
            objbulk.ColumnMappings.Add("inputdate", "inputdate");
            objbulk.ColumnMappings.Add("inputby", "inputby");
            objbulk.ColumnMappings.Add("reqstatus", "reqstatus");
            objbulk.ColumnMappings.Add("requestid", "requestid");
            objbulk.ColumnMappings.Add("productid", "productid");

            objbulk.ColumnMappings.Add("branchid", "branchid");
            objbulk.ColumnMappings.Add("purpose", "purpose");
            objbulk.ColumnMappings.Add("cust_name", "cust_name");
            objbulk.ColumnMappings.Add("dob", "dob");
            objbulk.ColumnMappings.Add("ktp", "ktp");

            objbulk.ColumnMappings.Add("cust_type", "cust_type");
            objbulk.ColumnMappings.Add("npwp", "npwp");
            objbulk.ColumnMappings.Add("status_bpkb", "status_bpkb");
            objbulk.ColumnMappings.Add("nama_bpkb", "nama_bpkb");
            objbulk.ColumnMappings.Add("pob", "pob");
            objbulk.ColumnMappings.Add("gender", "gender");
            objbulk.ColumnMappings.Add("mother_name", "mother_name");

            objbulk.ColumnMappings.Add("homeaddress", "homeaddress");
            objbulk.ColumnMappings.Add("phonenumber", "phonenumber");
            objbulk.ColumnMappings.Add("cid", "cid");
            objbulk.ColumnMappings.Add("curr_holder", "curr_holder");
            objbulk.ColumnMappings.Add("channel_id", "channel_id");
            objbulk.ColumnMappings.Add("channel_reff_id", "channel_reff_id");

            //inserting bulk Records into DataBase   
            objbulk.WriteToServer(table);
        }

        protected void GRID_ERROR_PageIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GRID_ERROR_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

            GRID_ERROR.PageIndex = e.NewPageIndex;
            GRID_ERROR.DataBind();
        }

        protected void GRID_ERROR_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void insertToDB(DataTable dt)
        {
            string sql = "exec sp_update_request @1,@2,@3,@4,@5,@6";
            for (int i = 0; i < dt.Rows.Count; i++)
            {

                #region Insert Apprequest

                string reqid = dt.Rows[i]["requestid"].ToString();
                NameValueCollection Keys = new NameValueCollection();
                NameValueCollection Fields = new NameValueCollection();
                Fields["inputdate"] = "getdate()";
                staticFramework.saveNVC(Keys, "requestid", reqid);
                staticFramework.saveNVC(Fields, "inputby", dt.Rows[i]["inputby"].ToString());
                staticFramework.saveNVC(Fields, "reqstatus", dt.Rows[i]["reqstatus"].ToString());

                staticFramework.saveNVC(Fields, "productid", dt.Rows[i]["productid"].ToString());
                staticFramework.saveNVC(Fields, "branchid", dt.Rows[i]["branchid"].ToString());
                staticFramework.saveNVC(Fields, "purpose", Convert.ToInt32(dt.Rows[i]["purpose"].ToString()));
                staticFramework.saveNVC(Fields, "cust_name", dt.Rows[i]["cust_name"].ToString());
                staticFramework.saveNVC(Fields, "dob", dt.Rows[i]["dob"].ToString());
                decimal ktp = Decimal.Parse(dt.Rows[i]["ktp"].ToString(), System.Globalization.NumberStyles.Any);
                staticFramework.saveNVC(Fields, "ktp", ktp);
                staticFramework.saveNVC(Fields, "cust_type", dt.Rows[i]["cust_type"].ToString());
                staticFramework.saveNVC(Fields, "npwp", dt.Rows[i]["npwp"].ToString());
                //staticFramework.saveNVC(Fields, "status_bpkb", dt.Rows[i]["status_bpkb"].ToString());
                //staticFramework.saveNVC(Fields, "nama_bpkb", dt.Rows[i]["nama_bpkb"].ToString());
                staticFramework.saveNVC(Fields, "pob", dt.Rows[i]["pob"].ToString());
                staticFramework.saveNVC(Fields, "gender", dt.Rows[i]["gender"].ToString());
                //staticFramework.saveNVC(Fields, "mother_name", dt.Rows[i]["mother_name"].ToString());
                //staticFramework.saveNVC(Fields, "homeaddress", dt.Rows[i]["homeaddress"].ToString());
                //staticFramework.saveNVC(Fields, "phonenumber", dt.Rows[i]["phonenumber"].ToString());
                staticFramework.saveNVC(Fields, "cid", "UPLOAD");
                //staticFramework.saveNVC(Fields, "channel_id", dt.Rows[i]["channel_id"].ToString());
                //staticFramework.saveNVC(Fields, "channel_reff_id", dt.Rows[i]["channel_reff_id"].ToString());
                staticFramework.save(Fields, Keys, "apprequest", conn);

                #endregion                

                object[] par = new object[] { dt.Rows[i]["requestid"].ToString(), "DRF", "APV", "SBT", Session["UserID"], null };
                conn.ExecNonQuery(sql, par, dbtimeout);
            }

        }

        protected void linkDownloadTemplate_Click(object sender, EventArgs e)
        {
            string url = ResolveUrl("~/TemplateFile/Template_Request_SLIK.xlsx");
            string file = System.IO.Path.GetFileName(url);

            Response.Clear();
            Response.ContentType = "text/html";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + file);
            Response.WriteFile(url); //use your file path here.
            Response.Flush();
            Response.End();

        }

        protected void BtnDownloadTemplate_Click(object sender, EventArgs e)
        {
            string query = "exec dbo.UspDownloadUploadExcelTemplate";
            DataSet ds = conn.GetDataSet(query, null, dbtimeout);
            DataTable dtSheetName = ds.Tables[0];
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (ExcelPackage excel = new ExcelPackage())
            {
                for (int i = 0; i < dtSheetName.Rows.Count; i++)
                {
                    string sheetName = GetFieldValueDatatable(dtSheetName, 1, i);
                    DataTable dt = ds.Tables[i + 1];
                    ExcelWorksheet ws = excel.Workbook.Worksheets.Add(sheetName);
                    ws.Cells["A1"].LoadFromDataTable(dt, true);
                }
                string fileName = "TemplateUploadSLIKRequest";

                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=\"" + fileName + ".xlsx\"");
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    excel.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    memoryStream.Close();
                }
                Response.End();
            }

        }

        public static string GetFieldValueDatatable(DataTable dt, int field, int row)
        {
            return DebtChecking.CommonForm.CustomFunction.GetFieldValueDatatable(dt, field, row);
        }

        private void BindGridError()
        {
            string query = "select Row_Number() over(order by NomorError) Nomor, * from dbo.ErrorUploadSLIKRequest where UserId = @1 order by NomorError";
            DataTable dt = conn.GetDataTable(query, new object[] { USERID }, dbtimeout);
            GridErrorSlikRequest.DataSource = dt;
            GridErrorSlikRequest.DataBind();
        }

        protected void panelErrorSlikRequest_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            BindGridError();
        }

        protected void GridErrorSlikRequest_PageIndexChanged(object sender, EventArgs e)
        {
            BindGridError();
        }

        protected void GridErrorSlikRequest_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridErrorSlikRequest.PageIndex = e.NewPageIndex;
        }

        protected void GridErrorSlikRequest_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
    }
}