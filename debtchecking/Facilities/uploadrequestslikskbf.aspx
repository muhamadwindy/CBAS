<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="uploadrequestslikskbf.aspx.cs"
    Inherits="DebtChecking.Facilities.uploadrequestslikskbf" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
    <Template:Admin ID="templ" runat="server" />
    <title></title>
    <script>
        function cekUploadFile(e) {
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }
        }
        function UploadDataSlik() {
            let upload = $("#ctl00_ContentPlaceHolder1_fileUploadExcel").val();
            if (upload !== "") {
                let fileUpload = $("#ctl00_ContentPlaceHolder1_fileUploadExcel").get(0);
                let files = fileUpload.files;
                let dataAttach = new FormData();
                //for (var i = 0; i < files.length; i++) {
                //    dataAttach.append(files[i].name, files[i]);
                //}
                dataAttach.append(files[0].name, files[0]);
                dataAttach.append("uploadfile", "uploadExcel");
                let url = '../HttpHandler/FileUploadDocument.ashx?upload=uploadexcel';
                $.ajax({
                    type: "POST",
                    url: url,
                    //async: false,
                    contentType: false,
                    processData: false,
                    data: dataAttach,
                    beforeSend: function () {
                        $("#divLoadAjax").show();
                    },
                    success: function (msg) {
                        let result = JSON.parse(msg);
                        if (result.status == "Error") {
                            $("#ctl00_ContentPlaceHolder1_tbl_error").hide();
                            ErrorMessage(result.error);
                        } else if (result.total !== "0") {
                            ErrorMessage("Error Validasi Upload File, Check Table Error");
                            $("#ctl00_ContentPlaceHolder1_tbl_error").show();
                            RefreshUploadError();
                        } else {
                            $("#ctl00_ContentPlaceHolder1_tbl_error").hide();
                            SuccessMessage("Upload Data Sukses");
                        }
                    },
                    error: function (err) {
                        ErrorMessage(err);
                    }, complete: function () {
                        $("#divLoadAjax").hide();
                    }
                });
            } else {
                WarningMessage("Pilih File yang akan di upload!");
            }
        }
        function RefreshUploadError() {
            panelErrorSlikRequest.PerformCallback();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-6">
                            <h4 class="card-title">Request SLIK Via Upload Excel File</h4>
                        </div>
                        <div class="col-sm-6 text-right">
                            <asp:LinkButton ID="linkDownloadTemplate" Visible="false" runat="server" OnClick="linkDownloadTemplate_Click">Download Template</asp:LinkButton>
                            <asp:LinkButton ID="BtnDownloadTemplate" runat="server" OnClick="BtnDownloadTemplate_Click">Download Template</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="exampleFormControlFile1">File Upload</label>
                                <input type="file" class="form-control-file" id="fileUploadExcel" runat="server" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="button" class="btn btn-sm btn-primary" onclick="UploadDataSlik();">Upload Data</button>
                    <asp:Button class="btn btn-sm btn-primary" Visible="false" Text="Upload" ID="btn_upload" runat="server" OnClick="btn_upload_Click" OnClientClick="javascript: return cekUploadFile();" />
                </div>
                <br>
                <br>
                <div width="100%" id="tbl_error" runat="server" style="display: none">
                    <div class="row">
                        <div class="col-sm-6">
                            <h6 style="padding-left: 20px">Detail Gagal Upload</h6>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-12">
                            <div style="display: none">
                                <asp:GridView ID="GRID_ERROR" ShowHeaderWhenEmpty="true" EmptyDataText="No records Found!" runat="server" Width="100%" CssClass="datatables table table-striped table-bordered table-hover"
                                    AutoGenerateColumns="False"
                                    AllowPaging="True"
                                    PageSize="20"
                                    OnPageIndexChanged="GRID_ERROR_PageIndexChanged"
                                    OnPageIndexChanging="GRID_ERROR_PageIndexChanging"
                                    OnRowDataBound="GRID_ERROR_RowDataBound">
                                    <PagerStyle HorizontalAlign="Right" />
                                    <Columns>
                                        <asp:BoundField DataField="cust_name" HeaderText="Nama Nasabah" />
                                        <asp:BoundField DataField="sheet" HeaderText="Nama Sheet" />
                                        <%--<asp:BoundField DataField="checkingslik" HeaderText="Checking SLIK 1 Bulan Terakhir" />--%>
                                        <asp:BoundField DataField="keterangan" HeaderText="Keterangan" />
                                    </Columns>
                                </asp:GridView>
                            </div>


                            <div class="table-responsive">
                                <dx:ASPxCallbackPanel ID="panelErrorSlikRequest" runat="server" Width="100%" BackColor="Transparent"
                                    ClientInstanceName="panelErrorSlikRequest" OnCallback="panelErrorSlikRequest_Callback">
                                    <ClientSideEvents EndCallback="function(s,e) { 
                    
                                    }" />
                                    <PanelCollection>
                                        <dx:PanelContent ID="PanelContent2" runat="server">
                                            <asp:GridView ID="GridErrorSlikRequest" runat="server" Width="100%" CssClass="datatables table table-striped table-bordered table-hover"
                                                AutoGenerateColumns="False"
                                                AllowPaging="True"
                                                PageSize="20"
                                                OnPageIndexChanged="GridErrorSlikRequest_PageIndexChanged"
                                                OnPageIndexChanging="GridErrorSlikRequest_PageIndexChanging"
                                                OnRowDataBound="GridErrorSlikRequest_RowDataBound">
                                                <PagerStyle HorizontalAlign="Right" />
                                                <Columns>
                                                    <asp:BoundField DataField="Nomor" HeaderText="No" />
                                                    <asp:BoundField DataField="NomorError" HeaderText="Nomor Error" />
                                                    <asp:BoundField DataField="CustName" HeaderText="Nama Nasabah" />
                                                    <asp:BoundField DataField="SheetName" HeaderText="SheetName" />
                                                    <asp:BoundField DataField="Deskripsi" HeaderText="Deskripsi Error" />
                                                    <asp:BoundField DataField="UploadDate" HeaderText="Tanggal Upload" DataFormatString="{0:dd-MM-yyyy hh:mm:ss}" />
                                                </Columns>
                                            </asp:GridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

</html>






