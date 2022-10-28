using DebtChecking.CommonForm;
using DevExpress.Spreadsheet;
using DMS.Tools;
using MWSFramework;
using System;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Web;

namespace DebtChecking.Facilities
{
    public partial class UploadBulkSKBF : DataPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private string genreqid(string cust_type)
        {
            string reqid = "";
            object[] param = new object[] { cust_type };
            conn.ExecReader("exec sp_gen_requestid @1", param, dbtimeout);
            if (conn.hasRow()) reqid = conn.GetFieldValue(0);
            return reqid;
        }

        protected void linkDownloadTemplate_Click(object sender, EventArgs e)
        {
            string url = ResolveUrl("~/TemplateFile/template.xlsx");
            string file = System.IO.Path.GetFileName(url);

            Response.Clear();
            Response.ContentType = "text/html";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + file);
            Response.WriteFile(url); //use your file path here.
            Response.Flush();
            Response.End();
        }

        private static string targetFolder;
        private static string targetPath;

        protected void UploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            targetFolder = HttpContext.Current.Server.MapPath("~/Upload/RequestSLIK");
            targetPath = Path.Combine(targetFolder, new Guid() + ".xlsx");
            e.UploadedFile.SaveAs(targetPath);
            e.CallbackData = e.UploadedFile.FileName;
        }

        private string getValWorkSheet(Worksheet sheetUtamane, string v)
        {
            string value = sheetUtamane.Cells[v].Value.ToString();
            return value.Contains(" - ") ? value.Split('-')[0].Trim() : value.Trim();
        }

        protected void mainPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter.StartsWith("excproc:"))
            {
                string fileName = e.Parameter.Split(':')[1];
                string messages = "";


                DataTable tempAppRequest = new DataTable();
                DataTable tempAppLoanInfo = new DataTable();
                DataTable tempAppTambahan = new DataTable();
                Workbook workbook = new Workbook();
                workbook.LoadDocument(targetPath, DocumentFormat.Xlsx);

                try
                {
                    int jumlahDataYangDiProses = 100;
                    Worksheet sheetUtamane = workbook.Worksheets[0];
                    #region kolom

                    tempAppRequest.Columns.Add("IsValid");
                    tempAppRequest.Columns.Add("Result");
                    tempAppRequest.Columns.Add("idsheet");
                    tempAppRequest.Columns.Add("requestid");
                    tempAppRequest.Columns.Add("cust_type");
                    tempAppRequest.Columns.Add("productid");
                    tempAppRequest.Columns.Add("branchid");
                    tempAppRequest.Columns.Add("purpose");
                    tempAppRequest.Columns.Add("cust_name");
                    tempAppRequest.Columns.Add("ktp");
                    tempAppRequest.Columns.Add("JenisIdentitas");
                    tempAppRequest.Columns.Add("pob");
                    tempAppRequest.Columns.Add("dob");
                    tempAppRequest.Columns.Add("JenisBadanUsaha");
                    tempAppRequest.Columns.Add("gender");
                    tempAppRequest.Columns.Add("mother_name");
                    tempAppRequest.Columns.Add("npwp");
                    tempAppRequest.Columns.Add("phonenumber");
                    tempAppRequest.Columns.Add("NoAplikasi");
                    tempAppRequest.Columns.Add("PICName");
                    tempAppRequest.Columns.Add("AktaPendirian");

                    tempAppLoanInfo.Columns.Add("RequestId");
                    tempAppLoanInfo.Columns.Add("ProductId");
                    tempAppLoanInfo.Columns.Add("DealerCode");
                    tempAppLoanInfo.Columns.Add("SalesId");
                    tempAppLoanInfo.Columns.Add("BrandId");
                    tempAppLoanInfo.Columns.Add("ModelId");
                    tempAppLoanInfo.Columns.Add("VarianId");
                    tempAppLoanInfo.Columns.Add("VehicleYearCode");
                    tempAppLoanInfo.Columns.Add("NoOfUnitId");
                    tempAppLoanInfo.Columns.Add("Otr");
                    tempAppLoanInfo.Columns.Add("DP");
                    tempAppLoanInfo.Columns.Add("LoanTerm");
                    tempAppLoanInfo.Columns.Add("InterestRate");

                    tempAppTambahan.Columns.Add("RequestId");
                    tempAppTambahan.Columns.Add("seq");
                    tempAppTambahan.Columns.Add("cust_type");
                    tempAppTambahan.Columns.Add("status_app");
                    tempAppTambahan.Columns.Add("cust_name");
                    tempAppTambahan.Columns.Add("jenisIdentitas");
                    tempAppTambahan.Columns.Add("ktp");
                    tempAppTambahan.Columns.Add("npwp");
                    tempAppTambahan.Columns.Add("pob");
                    tempAppTambahan.Columns.Add("dob");
                    tempAppTambahan.Columns.Add("mother_name");
                    tempAppTambahan.Columns.Add("gender");



                    #endregion
                    for (int i = 3; i <= jumlahDataYangDiProses + 2; i++)
                    {
                        DataRow dr = tempAppRequest.NewRow();
                        string idSheet = getValWorkSheet(sheetUtamane, "A" + i);
                        if (string.IsNullOrEmpty(idSheet))
                        {
                            continue;
                        }

                        dr["idsheet"] = idSheet;
                        string genreq = genreqid(getValWorkSheet(sheetUtamane, "B" + i));
                        dr["requestid"] = genreq;

                        string cust_type = getValWorkSheet(sheetUtamane, "B" + i);
                        dr["cust_type"] = cust_type;
                        dr["productid"] = getValWorkSheet(sheetUtamane, "C" + i);
                        string branchid = Convert.ToInt32(getValWorkSheet(sheetUtamane, "D" + i)).ToString("0000");
                        dr["branchid"] = branchid;
                        dr["purpose"] = getValWorkSheet(sheetUtamane, "E" + i);
                        dr["cust_name"] = getValWorkSheet(sheetUtamane, "F" + i);
                        string ktpMentah = getValWorkSheet(sheetUtamane, cust_type == "PSH" ? "O" + i.ToString() : "I" + i.ToString());
                        decimal ktp = Decimal.Parse(ktpMentah == "" ? "0" : ktpMentah, System.Globalization.NumberStyles.Any);

                        dr["ktp"] = ktp;
                        dr["AktaPendirian"] = getValWorkSheet(sheetUtamane, "G" + i);
                        dr["JenisIdentitas"] = getValWorkSheet(sheetUtamane, "H" + i);
                        dr["pob"] = getValWorkSheet(sheetUtamane, "J" + i);
                        DateTime dob = DateTime.Parse(getValWorkSheet(sheetUtamane, "K" + i));
                        dr["dob"] = dob;
                        dr["JenisBadanUsaha"] = getValWorkSheet(sheetUtamane, "L" + i);
                        dr["gender"] = (getValWorkSheet(sheetUtamane, "M" + i)).ToString() == "Perempuan" ? "F" : "M";
                        dr["mother_name"] = getValWorkSheet(sheetUtamane, "N" + i);
                        string npwpMentah = getValWorkSheet(sheetUtamane, "O" + i) == "" ? "0" : getValWorkSheet(sheetUtamane, "O" + i);
                        decimal npwp = Decimal.Parse(npwpMentah == "" ? "0" : npwpMentah, System.Globalization.NumberStyles.Any);
                        dr["npwp"] = npwp;

                        dr["phonenumber"] = getValWorkSheet(sheetUtamane, "P" + i);
                        dr["NoAplikasi"] = getValWorkSheet(sheetUtamane, "Q" + i);
                        dr["PICName"] = getValWorkSheet(sheetUtamane, "R" + i);

                        tempAppRequest.Rows.Add(dr);


                        DataRow drLoan = tempAppLoanInfo.NewRow();
                        drLoan["RequestId"] = genreq;
                        drLoan["ProductId"] = getValWorkSheet(sheetUtamane, "C" + i);
                        drLoan["DealerCode"] = getValWorkSheet(sheetUtamane, "S" + i);
                        drLoan["SalesId"] = getValWorkSheet(sheetUtamane, "T" + i);
                        drLoan["BrandId"] = getValWorkSheet(sheetUtamane, "U" + i);
                        drLoan["ModelId"] = getValWorkSheet(sheetUtamane, "V" + i);
                        drLoan["VarianId"] = getValWorkSheet(sheetUtamane, "W" + i);
                        drLoan["VehicleYearCode"] = getValWorkSheet(sheetUtamane, "Y" + i);
                        drLoan["NoOfUnitId"] = getValWorkSheet(sheetUtamane, "Z" + i);
                        drLoan["Otr"] = getValWorkSheet(sheetUtamane, "AA" + i);
                        drLoan["DP"] = getValWorkSheet(sheetUtamane, "AB" + i);
                        drLoan["LoanTerm"] = getValWorkSheet(sheetUtamane, "AC" + i);
                        drLoan["InterestRate"] = getValWorkSheet(sheetUtamane, "AD" + i);

                        tempAppLoanInfo.Rows.Add(drLoan);
                    }




                    Worksheet sheetLainnya = workbook.Worksheets[1];

                    for (int i = 2; i <= 101; i++)
                    {
                        string NoInSheet = getValWorkSheet(sheetLainnya, "A" + i);
                        if (string.IsNullOrEmpty(NoInSheet))
                        {
                            continue;
                        }
                        NameValueCollection Keys = new NameValueCollection();
                        NameValueCollection Fields = new NameValueCollection();
                        string requestid = "";
                        for (int idx_app = 0; idx_app < tempAppRequest.Rows.Count; idx_app++)
                        {
                            string dataapp = tempAppRequest.Rows[idx_app]["idsheet"].ToString();
                            if (NoInSheet == dataapp)
                            {
                                requestid = tempAppRequest.Rows[idx_app]["requestid"].ToString();
                                break;
                            }
                        }

                        if (requestid == "")
                        {
                            break;
                        }

                        DataRow drSLIKTambahan = tempAppTambahan.NewRow();
                        drSLIKTambahan["requestid"] = requestid;
                        drSLIKTambahan["seq"] = "";
                        drSLIKTambahan["cust_type"] = getValWorkSheet(sheetLainnya, "B" + i);
                        drSLIKTambahan["status_app"] = getValWorkSheet(sheetLainnya, "C" + i);
                        drSLIKTambahan["cust_name"] = getValWorkSheet(sheetLainnya, "D" + i);
                        drSLIKTambahan["jenisIdentitas"] = getValWorkSheet(sheetLainnya, "F" + i);
                        decimal ktp = Decimal.Parse(getValWorkSheet(sheetLainnya, getValWorkSheet(sheetLainnya, "B" + i) == "PSH" ? "G" : "E" + i), System.Globalization.NumberStyles.Any);

                        drSLIKTambahan["ktp"] = ktp;
                        drSLIKTambahan["npwp"] = getValWorkSheet(sheetLainnya, "H" + i);
                        drSLIKTambahan["pob"] = getValWorkSheet(sheetLainnya, "I" + i);
                        drSLIKTambahan["dob"] = getValWorkSheet(sheetLainnya, "J" + i);
                        drSLIKTambahan["gender"] = getValWorkSheet(sheetLainnya, "K" + i);
                        drSLIKTambahan["mother_name"] = getValWorkSheet(sheetLainnya, "L" + i);

                        tempAppTambahan.Rows.Add(drSLIKTambahan);

                    }

                    //misale ono validasi 
                    if (IsDataValid(tempAppRequest, tempAppLoanInfo, tempAppTambahan))
                    {
                        foreach (DataRow row in tempAppRequest.Rows)
                        {
                            NameValueCollection Keys = new NameValueCollection();
                            NameValueCollection Fields = new NameValueCollection();

                            staticFramework.saveNVC(Keys, "requestid", row["requestid"]);
                            staticFramework.saveNVC(Fields, "inputby", USERID);
                            staticFramework.saveNVC(Fields, "reqstatus", "ADM");
                            staticFramework.saveNVC(Fields, "cust_type", row["cust_type"]);
                            staticFramework.saveNVC(Fields, "productid", row["productid"]);
                            staticFramework.saveNVC(Fields, "branchid", row["branchid"]);
                            staticFramework.saveNVC(Fields, "purpose", row["purpose"]);
                            staticFramework.saveNVC(Fields, "cust_name", row["cust_name"]);
                            staticFramework.saveNVC(Fields, "ktp", row["ktp"]);
                            staticFramework.saveNVC(Fields, "AktaPendirian", row["AktaPendirian"]);
                            staticFramework.saveNVC(Fields, "JenisIdentitas", row["JenisIdentitas"]);
                            staticFramework.saveNVC(Fields, "pob", row["pob"]);
                            staticFramework.saveNVC(Fields, "dob", row["dob"]);
                            staticFramework.saveNVC(Fields, "JenisBadanUsaha", row["JenisBadanUsaha"]);
                            staticFramework.saveNVC(Fields, "gender", row["gender"]);
                            staticFramework.saveNVC(Fields, "mother_name", row["mother_name"]);
                            staticFramework.saveNVC(Fields, "npwp", row["npwp"]);
                            staticFramework.saveNVC(Fields, "phonenumber", row["phonenumber"]);
                            staticFramework.saveNVC(Fields, "NoAplikasi", row["NoAplikasi"]);
                            staticFramework.saveNVC(Fields, "PICName", row["PICName"]);
                            Fields["inputdate"] = "getdate()";
                            staticFramework.save(Fields, Keys, "apprequest", conn);

                            object[] parVal = new object[] { row["requestid"].ToString(), USERID };
                            DataTable dataValidasi = conn.GetDataTable("exec sp_validasi_request @1, @2", parVal, dbtimeout);

                            if (dataValidasi.Rows.Count > 0)
                            {
                                if (dataValidasi.Rows[0]["valid"].ToString() == "1")
                                {

                                    string sqlAudit = "select * from dbo.apprequest where requestid = @1";
                                    object[] parAudit = new object[] { row["requestid"].ToString() };
                                    DataTable dtAppRequestBefore = conn.GetDataTable(sqlAudit, parAudit, dbtimeout);

                                    string sql = "exec sp_update_request @1,@2,@3,@4,@5,@6";

                                    object[] param = new object[] { row["requestid"].ToString(), "DRF", "APV", "SBT", USERID, null };
                                    conn.ExecNonQuery(sql, param, dbtimeout);
                                    NameValueCollection KeysSumit = new NameValueCollection();
                                    NameValueCollection FieldsSubmit = new NameValueCollection();
                                    Fields["reqdate"] = "getdate()";
                                    staticFramework.saveNVC(Keys, "requestid", row["requestid"].ToString());
                                    staticFramework.save(Fields, Keys, "apprequest", conn);

                                    DataTable dtAppRequestAfter = conn.GetDataTable(sqlAudit, parAudit, dbtimeout);
                                    CommonClass cm = new CommonClass();

                                    cm.InsertAuditTrail("apprequest", null, USERID, dtAppRequestBefore, dtAppRequestAfter);


                                }
                            }
                        }

                        foreach (DataRow row in tempAppLoanInfo.Rows)
                        {
                            NameValueCollection Keys = new NameValueCollection();
                            NameValueCollection Fields = new NameValueCollection();

                            staticFramework.saveNVC(Keys, "requestid", row["requestid"]);
                            staticFramework.saveNVC(Fields, "ProductId", row["ProductId"]);
                            staticFramework.saveNVC(Fields, "DealerCode", row["DealerCode"]);
                            staticFramework.saveNVC(Fields, "SalesId", row["SalesId"]);
                            staticFramework.saveNVC(Fields, "BrandId", row["BrandId"]);
                            staticFramework.saveNVC(Fields, "ModelId", row["ModelId"]);
                            staticFramework.saveNVC(Fields, "VarianId", row["VarianId"]);
                            staticFramework.saveNVC(Fields, "VehicleYearCode", row["VehicleYearCode"]);
                            staticFramework.saveNVC(Fields, "NoOfUnitId", row["NoOfUnitId"]);
                            staticFramework.saveNVC(Fields, "Otr", row["Otr"]);
                            staticFramework.saveNVC(Fields, "DP", row["DP"]);
                            staticFramework.saveNVC(Fields, "LoanTerm", row["LoanTerm"]);
                            staticFramework.saveNVC(Fields, "InterestRate", row["InterestRate"]);
                            staticFramework.save(Fields, Keys, "AppLoanInfo", conn);
                        }

                        foreach (DataRow row in tempAppTambahan.Rows)
                        {

                            NameValueCollection Keys = new NameValueCollection();
                            NameValueCollection Fields = new NameValueCollection();


                            staticFramework.saveNVC(Keys, "requestid", row["requestid"]);
                            staticFramework.saveNVC(Keys, "seq", "");
                            staticFramework.saveNVC(Fields, "cust_type", row["cust_type"]);
                            staticFramework.saveNVC(Fields, "status_app", row["status_app"]);
                            staticFramework.saveNVC(Fields, "cust_name", row["cust_name"]);
                            staticFramework.saveNVC(Fields, "jenisIdentitas", row["jenisIdentitas"]);
                            staticFramework.saveNVC(Fields, "ktp", row["ktp"]);
                            staticFramework.saveNVC(Fields, "npwp", row["npwp"]);
                            staticFramework.saveNVC(Fields, "pob", row["pob"]);
                            staticFramework.saveNVC(Fields, "dob", row["dob"]);
                            staticFramework.saveNVC(Fields, "gender", row["gender"]);
                            staticFramework.saveNVC(Fields, "mother_name", row["mother_name"]);

                            Fields["inputdate"] = "getdate()";
                            staticFramework.save(Fields, Keys, "apprequestsupp",
                                "DECLARE @seq INT \n" +
                                "SELECT @seq=ISNULL(MAX(seq),0)+1 FROM apprequestsupp " +
                                "WHERE requestid='" + row["requestid"] + "' \n", conn);
                        }


                        messages = "File " + fileName + " berhasil diproses!";
                    }
                    else
                    {
                        messages = "File " + fileName + " gagal diproses!";
                    }



                }
                catch (Exception ex)
                {
                    messages = "Upload Gagal, Mohon Periksa Kembali Dokumen Anda. Message : " + ex.Message;
                }
                finally
                {
                    gridSummary.DataSource = tempAppRequest;
                    gridSummary.DataBind();
                    File.Delete(targetPath);
                }

                mainPanel.JSProperties["cp_alert"] = messages;
            }
        }

        private bool IsDataValid(DataTable tempAppRequest, DataTable tempAppLoanInfo, DataTable tempAppTambahan)
        {
            bool result = true;
            foreach (DataRow row in tempAppRequest.Rows)
            {
                #region Validasi SLIK Utama
                string message = "";

                if (row["branchid"].ToString() == "")
                {
                    message += "Cabang Harus Diisi" + "<br />";
                }

                if (row["purpose"].ToString() == "")
                {
                    message += "Tujuan SLIK Harus Diisi" + "<br />";
                }

                if (row["productid"].ToString() == "")
                {
                    message += "Product Harus Diisi" + "<br />";
                }

                if (row["cust_name"].ToString() == "")
                {
                    message += "Customer Name/Company Name Harus Diisi" + "<br />";
                }

                if (row["cust_type"].ToString() == "IND" && row["ktp"].ToString() == "0")
                {
                    message += "KTP No. Harus Diisi" + "<br />";
                }
                if (row["pob"].ToString() == "")
                {
                    message += "Tempat Lahir/Pendirian Harus Diisi" + "<br />";
                }

                if (row["dob"].ToString() == "")
                {
                    message += "Tanggal Lahir/Pendirian(MM/DD/YYYY) Harus Diisi" + "<br />";
                }

                if (row["cust_type"].ToString() == "IND" && row["gender"].ToString() == "")
                {
                    message += "Gender Harus Diisi" + "<br />";
                }

                if (row["cust_type"].ToString() == "PSH" && row["npwp"].ToString() == "0")
                {
                    message += "NPWP Harus Diisi" + "<br />";
                }

                if (row["phonenumber"].ToString() == "")
                {
                    message += "Nomor Telepon Harus Diisi" + "<br />";
                }

                if (row["cust_type"].ToString() == "PSH" && row["PICName"].ToString() == "")
                {
                    message += "Nama PIC Harus Diisi" + "<br />";
                }

                if (row["cust_type"].ToString() == "PSH" && row["AktaPendirian"].ToString() == "")
                {
                    message += "Akta Pendirian Harus Diisi" + "<br />";
                }

                if (row["cust_type"].ToString() == "PSH" && row["JenisBadanUsaha"].ToString() == "")
                {
                    message += "Jenis Badan Usaha Harus Diisi" + "<br />";
                }

                if (row["purpose"].ToString() == "1")
                {
                    for (int i = 0; i < tempAppLoanInfo.Rows.Count; i++)
                    {
                        if (tempAppLoanInfo.Rows[i]["requestid"].ToString() == row["requestid"].ToString())
                        {
                            #region Loan Info
                            DataRow rowLoan = tempAppLoanInfo.Rows[i];
                            {
                                if (rowLoan["DealerCode"].ToString() == "")
                                {
                                    message += "Dealer Harus Diisi" + "<br />";
                                }
                                if (rowLoan["SalesId"].ToString() == "")
                                {
                                    message += "Sales Harus Diisi" + "<br />";
                                }
                                if (rowLoan["ModelId"].ToString() == "")
                                {
                                    message += "Model Harus Diisi" + "<br />";
                                }
                                if (rowLoan["VarianId"].ToString() == "")
                                {
                                    message += "Varian Harus Diisi" + "<br />";
                                }
                                if (rowLoan["VehicleYearCode"].ToString() == "")
                                {
                                    message += "vehicle Year Harus Diisi" + "<br />";
                                }
                                if (rowLoan["NoOfUnitId"].ToString() == "")
                                {
                                    message += "No of Unit Harus Diisi" + "<br />";
                                }
                                if (rowLoan["Otr"].ToString() == "")
                                {
                                    message += "OTR Harus Diisi" + "<br />";
                                }
                                if (rowLoan["DP"].ToString() == "")
                                {
                                    message += "DP Harus Diisi" + "<br />";
                                }
                                if (rowLoan["LoanTerm"].ToString() == "")
                                {
                                    message += "Loan Term Harus Diisi" + "<br />";
                                }
                                if (rowLoan["InterestRate"].ToString() == "")
                                {
                                    message += "Interest Rate Harus Diisi" + "<br />";
                                }
                            }
                            #endregion 
                            break;
                        }

                    }
                }

                if (message != "")
                {
                    result = false;
                }
                row["IsValid"] = message == "" ? "Valid" : "Tidak Valid";
                row["Result"] = message;

                #endregion
            }

            return result;
        }


    }
}