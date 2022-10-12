<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApprovalSLIK.aspx.cs"
    Inherits="DebtChecking.Facilities.ApprovalSLIK" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <title>Approval SLIK Checking</title>
    <!-- #include file="~/include/onepost.html" -->

    <Template:Admin runat="server" ID="Template" />
    <script>

        function setoverlaypage() {
            $('#overlaypage').attr("class", "overlay");
        }

        function removerlaypage() {
            $('#overlaypage').attr("class", "hidden");
        }

        $(document).on("click", ".gdownload", function () {
            var docid = $(this).data('docid');
            console.log(docid);
            gridPanel.PerformCallback('r:' + docid);
        });
    </script>
    <style>
        .hidden {
            display: none;
        }
    </style>
    <script>
        function actback() {
            if (confirm('Anda yakin?')) {
                setoverlaypage();
                callbackpopup(PopupSID, PanelSID, 'v');
            }
        }
        function actaprv() {
            if (confirm('Anda yakin?')) {
                setoverlaypage();
                callback(mainPanel, 'a');
            }
        }
        function actdel() {
            if (confirm('Anda Yakin?')) {
                setoverlaypage();
                callback(mainPanel, 'd');
            }
        }
        function actrej() {
            if (confirm('Anda yakin?')) {
                setoverlaypage();
                callbackpopup(PopupSID, PanelSID, 'r');
            }
        }
    </script>
</head>
<body class="text-sm">
    <form id="form1" runat="server">
        <asp:HiddenField ID="productid" runat="server"></asp:HiddenField>

        <div class="card card-primary card-outline">

            <!-- /.card-header -->
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-12">
                        <h4 class="card-title">Request SLIK checking</h4>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-6">
                        <table class="table table-sm">
                            <tr>
                                <td width="150px">Request ID</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="requestid" runat="server" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Request By</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="inputby" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Request Date</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="reqdate" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-sm-6">
                        <table class="table  table-sm">
                            <tr>
                                <td width="150px">Jenis Produk</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="productdesc" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Cabang</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="branchname" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Tujuan SLIK Checking</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="purposedesc" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><b>Hasil SLIK Checking</b></td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="remark" CssClass="label label-warning" runat="server" Font-Bold="true"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="row mt-1">
                    <div class="col-sm-12">
                        <h4 class="card-title">Informasi Debitur</h4>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-6">
                        <table class="table table-sm">
                            <tr>
                                <td width="150px">Nama Customer</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="cust_name" runat="server" Font-Bold="true"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Tgl Lahir/Pendirian</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="dob" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Nomor KTP / Akta</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="ktp" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Jenis Customer</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="cust_type" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Nomor NPWP</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="npwp" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-sm-6">
                        <table class="table table-sm">
                            <tr>
                                <td width="150px">Tempat Lahir</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="pob" runat="server"></asp:Label></td>
                            </tr>
                            <tr id="tr_gender" runat="server">
                                <td>Jenis Kelamin</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="gender_desc" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="tr_mother_name" runat="server">
                                <td>Nama Ibu Kandung</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="mother_name" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Alamat</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="homeaddress" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Nomor Telp</td>
                                <td>:</td>
                                <td>
                                    <asp:Label ID="phonenumber" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                </div>



                <div class="row mt-1">
                    <div class="col-sm-12">
                        <h4 class="card-title">Informasi Produk</h4>
                    </div>
                </div>
                <hr />

                <div>
                    <div id="divInfoProduk" style="display: none">
                        <div class="card card-primary card-outline">
                            <div class="card-header">
                                <h4 class="card-title">Info Produk</h4>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                <div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Dealer</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" id="h_DealerCode" runat="server" />


                                                    <dx:ASPxCallbackPanel runat="server" ID="panelDealer" ClientInstanceName="gridPanel" OnCallback="panelDealer_Callback">
                                                        <ClientSideEvents EndCallback="function(s, e) {}" />
                                                        <PanelCollection>
                                                            <dx:PanelContent ID="PanelContent4" runat="server">
                                                                <asp:DropDownList ID="DealerCode" runat="server" onchange="mainPanel_h_DealerCode.value=this.value"
                                                                    CssClass="form-control form-control-sm input-sm select2">
                                                                </asp:DropDownList>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>



                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Sales Person</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" id="h_SalesPerson" runat="server" />
                                                    <asp:DropDownList ID="SalesPerson" runat="server" onchange="mainPanel_h_SalesPerson.value=this.value;" CssClass="form-control form-control-sm input-sm select2" data-info="Sales Person" Style="width: 100%"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Brand</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" runat="server" id="h_Brand" />
                                                    <asp:DropDownList ID="Brand" runat="server" onchange="mainPanel_h_Brand.value=this.value;panelModel.PerformCallback();panelLoanTerm.PerformCallback()" data-info="Brand" CssClass="form-control form-control-sm input-sm select2" Style="width: 100%"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Model</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" runat="server" id="h_Model" />
                                                    <dx:ASPxCallbackPanel runat="server" ID="panelModel" ClientInstanceName="panelModel" OnCallback="panelModel_Callback">
                                                        <ClientSideEvents EndCallback="function(s, e) {
                                                                            $('#mainPanel_panelModel_Model').select2({
                                                                                theme: 'bootstrap4'
                                                                            })
                                                                            
                                                                            }" />
                                                        <PanelCollection>
                                                            <dx:PanelContent ID="PanelContent5" runat="server">
                                                                <asp:DropDownList ID="Model" runat="server" CssClass="form-control"
                                                                    onchange="mainPanel_h_Model.value=this.value;panelVarian.PerformCallback()" data-info="Model" Style="width: 100%">
                                                                </asp:DropDownList>
                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>

                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Varian</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" id="h_Varian" runat="server" />

                                                    <dx:ASPxCallbackPanel runat="server" ID="panelVarian" ClientInstanceName="panelVarian" OnCallback="panelVarian_Callback">
                                                        <ClientSideEvents EndCallback="function(s, e) {
                                                                            $('#mainPanel_panelVarian_Varian').select2({
                                                                                theme: 'bootstrap4'
                                                                            })
                                                                            
                                                                            }" />
                                                        <PanelCollection>
                                                            <dx:PanelContent ID="PanelContent6" runat="server">
                                                                <asp:DropDownList ID="Varian" runat="server" CssClass="form-control" Style="width: 100%" onchanger="mainPanel_h_Varian.value=this.value">
                                                                </asp:DropDownList>

                                                            </dx:PanelContent>
                                                        </PanelCollection>
                                                    </dx:ASPxCallbackPanel>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Vehicle Year</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" id="h_VehicleYear" runat="server" />
                                                    <asp:DropDownList ID="VehicleYear" runat="server" onchange="mainPanel_h_VehicleYear.value=this.value;panelLoanTerm.PerformCallback();" CssClass="form-control form-control-sm input-sm select2" data-info="Vehicle Year" Style="width: 100%"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">No. of Unit</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" id="h_NoOfUnit" runat="server" />
                                                    <asp:DropDownList ID="NoOfUnit" onchange="mainPanel_h_NoOfUnit.value=this.value;" runat="server" CssClass="form-control form-control-sm input-sm select2"
                                                        data-info="No. of Unit" Style="width: 100%">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">OTR</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="OTR" runat="server" CssClass="form-control form-control-sm" data-role="autonumeric" data-info="OTR"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">DP</label>
                                                <div class="col-sm-4">
                                                    <div class="input-group">
                                                        <asp:TextBox ID="DP" runat="server" ClientIDMode="Static" CssClass="form-control form-control-sm pull-right" data-role="autonumeric" data-info="DP" MaxLength="5"></asp:TextBox>
                                                        <div class="input-group-addon">
                                                            <span>%</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Loan Term</label>
                                                <div class="col-sm-4">
                                                    <div class="input-group">
                                                        <%--<asp:TextBox ID="LoanTerm" runat="server" ClientIDMode="Static" CssClass="form-control form-control-sm pull-right numeric" data-info="Loan Term" MaxLength="3"></asp:TextBox>--%>
                                                        <div class="col-sm-6" style="padding: 0px">

                                                            <input type="hidden" runat="server" id="h_LoanTerm" />
                                                            <dx:ASPxCallbackPanel runat="server" ID="panelLoanTerm" ClientInstanceName="panelLoanTerm" OnCallback="panelLoanTerm_Callback">
                                                                <ClientSideEvents EndCallback="function(s, e) {
                                                                            $('#mainPanel_panelLoanTerm_LoanTerm').select2({
                                                                                theme: 'bootstrap4'
                                                                            })
                                                                            
                                                                            }" />
                                                                <PanelCollection>
                                                                    <dx:PanelContent ID="PanelContent7" runat="server">
                                                                        <asp:DropDownList ID="LoanTerm" runat="server" onchange="mainPanel_h_LoanTerm.value=this.value" CssClass="form-control form-control-sm pull-right">
                                                                        </asp:DropDownList>
                                                                    </dx:PanelContent>
                                                                </PanelCollection>
                                                            </dx:ASPxCallbackPanel>

                                                        </div>
                                                        <div class="input-group-addon">
                                                            <span>months</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Interest Rate</label>
                                                <div class="col-sm-4">
                                                    <div class="input-group">
                                                        <asp:TextBox ID="InterestRate" runat="server" ClientIDMode="Static" CssClass="form-control form-control-sm pull-right" data-info="Interest Rate" onkeypress="return isNumberKey(event)" MaxLength="5"></asp:TextBox>
                                                        <div class="input-group-addon">
                                                            <span>%</span>
                                                        </div>
                                                        <%--<a href="requestslikskbf.aspx">requestslikskbf.aspx</a>--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row top-buffer" id="divDownloadDocument" runat="server" style="display: none">
                                                <label class="col-sm-4 col-form-label">File Doc</label>
                                                <div class="col-sm-8">
                                                    <button type="button" onclick="DownloadFileDoc();" class="btn btn-sm btn-success">
                                                        <i class="fa fa-download" aria-hidden="true"></i>Download File
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </div>

                            </div>
                            <br />

                        </div>

                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-sm-12">
                        <h4 class="card-title">Foto</h4>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-12">

                        <dx:ASPxCallbackPanel runat="server" ID="gridPanel" ClientInstanceName="gridPanel" OnCallback="gridPanel_Callback">
                            <ClientSideEvents EndCallback="function(s, e) {
                                                            if (s.cp_new != '' && s.cp_new != undefined) {
                                                                window.open(s.cp_new,'_parent');
                                                                s.cp_new = '';
                                                            }

                                                            if (s.cp_url != '' && s.cp_url != undefined) {
                                                                window.open(s.cp_url,'_blank,toolbar=no, location=yes,status=no,menubar=no,scrollbars=yes,resizable=no');
                                                                s.cp_url = '';
                                                            }

                                                            if (s.cp_alert != '' && s.cp_alert != undefined) {
                                                                alert(s.cp_alert);
                                                                s.cp_alert = '';
                                                            }

                                                        }" />
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent9" runat="server">
                                    <asp:GridView ID="GridFileUpload" ShowHeaderWhenEmpty="true" EmptyDataText="No records Found" runat="server" Width="100%" CssClass="datatables table table-striped table-bordered table-hover table-sm"
                                        AutoGenerateColumns="False"
                                        AllowPaging="True"
                                        PageSize="10"
                                        OnPageIndexChanged="GridFileUpload_PageIndexChanged"
                                        OnPageIndexChanging="GridFileUpload_PageIndexChanging"
                                        OnRowDataBound="GridFileUpload_RowDataBound">
                                        <PagerStyle HorizontalAlign="Right" />
                                        <FooterStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <HeaderStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />

                                        <Columns>
                                            <asp:TemplateField HeaderText="Terunggah">
                                                <ItemTemplate>
                                                    <input type="checkbox" id="cbUPLOADED" runat="server" data-uploaded='<%# Eval("UPLOADED") %>'>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DOC_DESC" HeaderText="Document Type" />
                                            <asp:BoundField DataField="WAJIB" HeaderText="Wajib" />
                                            <%--<asp:BoundField DataField="DOC_NAME" HeaderText="File Name" HeaderStyle-CssClass="hidden-xs" ItemStyle-CssClass="hidden-xs" />--%>
                                            <asp:BoundField DataField="UPLOAD_BY" HeaderText="Upload By" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                            <asp:BoundField DataField="UPLOAD_DATE" HeaderText="Upload Date" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                            <asp:BoundField DataField="GEOTAG_ADDRESS" HeaderText="Upload Location" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                            <asp:TemplateField HeaderText="Function">
                                                <ItemStyle Width="15%"></ItemStyle>
                                                <ItemTemplate>

                                                    <a id="lnkDownload" runat="server" data-toggle="tooltip" title="View File"
                                                        data-docid='<%# Eval("DOC_ID") %>'
                                                        data-uploadby='<%# Eval("UPLOAD_BY") %>'
                                                        class="gdownload btn btn-xs btn-success">
                                                        <i class="fa fa-eye" aria-hidden="true" title="view"></i>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-sm-12">
                        <h4 class="card-title">Permintaan SLIK Checking Lainnya/Tambahan</h4>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-12">
                        <dx:ASPxCallbackPanel ID="mainPanel" runat="server" Width="100%"
                            ClientInstanceName="mainPanel" OnCallback="mainPanel_Callback">
                            <ClientSideEvents EndCallback="function(s, e) {
                                    removerlaypage();
                                    if (s.cp_new != '' && s.cp_new != undefined) {
                                        window.open(s.cp_new,'_parent');
                                        s.cp_new = '';
                                    }

                                    if (s.cp_url != '' && s.cp_url != undefined) {
                                        window.open(s.cp_url,'_blank,toolbar=no, location=yes,status=no,menubar=no,scrollbars=yes,resizable=no');
                                        s.cp_url = '';
                                    }

                                    if (s.cp_redirect != '' && s.cp_redirect != undefined) {
                                        setoverlaypage();
                                    }

                                    if (s.cp_alert != '' && s.cp_alert != undefined) {
                                        alert(s.cp_alert);
                                        s.cp_alert = '';
                                    }
                                
                                    $('select').select2({
                                        theme: 'bootstrap4'
                                    })
                             }" />
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent1" runat="server">
                                    <table width="100%" class="Box1">

                                        <tr id="tr_suppheader" runat="server">
                                            <td colspan="2" class="H1"></td>
                                        </tr>
                                        <tr id="tr_supplement" runat="server">
                                            <td colspan="2">
                                                <dx:ASPxGridView ID="GridViewSuppl" runat="server" Width="100%" AutoGenerateColumns="False"
                                                    ClientInstanceName="GridViewSuppl" KeyFieldName="seq" OnLoad="GridViewSuppl_Load">

                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Nama" FieldName="cust_name"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Hubungan" FieldName="relation"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Tgl Lahir/Pendirian" FieldName="dob">
                                                            <PropertiesTextEdit DisplayFormatString="dd/MMM/yyyy"></PropertiesTextEdit>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Nomor KTP/Akta" FieldName="ktp"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="NPWP" FieldName="npwp"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Tempat Lahir" FieldName="pob"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Alamat" FieldName="homeaddress"></dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="No Telp" FieldName="phonenumber"></dx:GridViewDataTextColumn>
                                                    </Columns>
                                                    <SettingsPager PageSize="20" />
                                                    <SettingsBehavior AllowGroup="False" />
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table width="100%">
                                        <tr id="tr_submit" runat="server">
                                            <td align="center">
                                                <input type="button" id="btn_back" value="Reverse" runat="server" class="btn btn-warning" onclick="actback();" />
                                                <input type="button" id="btn_apprv" value="Approve" runat="server" class="btn btn-success" onclick="actaprv();" />
                                                <input type="button" id="btn_del" runat="server" value="Delete" class="m-1 btn btn-danger" onclick="actdel();" />
                                                <input type="button" id="btn_reject" value="Reject" runat="server" class="btn btn-danger" onclick="actrej();" />
                                            </td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </div>
                </div>

                <div class="row mt-1">
                    <div class="col-sm-12">
                        <h4 class="card-title">Histori</h4>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-12">
                        <asp:GridView ID="GRID_NOTES" ShowHeaderWhenEmpty="true" EmptyDataText="No records Found" runat="server" Width="100%" CssClass="table table-striped table-bordered table-hover table-sm" AutoGenerateColumns="false">
                            <FooterStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                            <HeaderStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                            <Columns>
                                <asp:BoundField DataField="seq" HeaderText="No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%" Visible="false" />
                                <asp:TemplateField HeaderText="Tgl Masuk" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%#FormatedValue(Eval("in_date")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tgl Keluar" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%#FormatedValue(Eval("out_date")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="userid" HeaderText="User ID" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10%" />
                                <asp:BoundField DataField="sts_desc" HeaderText="Status" ItemStyle-HorizontalAlign="left" ItemStyle-Width="10%" />
                                <asp:BoundField DataField="act_desc" HeaderText="Action" ItemStyle-HorizontalAlign="left" ItemStyle-Width="10%" />
                                <asp:BoundField DataField="comment" HeaderText="Comment" ItemStyle-HorizontalAlign="left" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div id="overlaypage" class="hidden">
                <i class="fas fa-2x fa-sync-alt"></i>
            </div>

            <dx:ASPxPopupControl ID="PopupSID" ClientInstanceName="PopupSID" runat="server" HeaderText="Comment" Width="600px"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                CloseAction="CloseButton" Modal="True" AllowDragging="True" EnableAnimation="False">
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">
                        <dx:ASPxCallbackPanel ID="PanelSID" runat="server" ClientInstanceName="PanelSID" OnCallback="PanelSID_Callback">
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent8" runat="server">

                                    <table width="100%" class="Box1">
                                        <tr>
                                            <td width="100%">
                                                <asp:TextBox runat="server" ID="comment" CssClass="mandatory" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <input type="button" id="btn_confirm" runat="server" value="  O K  " class="Bt1" />
                                                <input type="button" id="Button2" value="Cancel" class="Bt1" onclick="PopupSID.Hide()" />
                                            </td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
        </div>

        <script>

            function CheckTujuan(val = "") {
                if (val == "") {
                    val = $('#purposedesc').html();

                }
                if (val === "Penilaian Calon Debitur") {
                    $("#divInfoProduk").show();
                } else {
                    $("#divInfoProduk").hide();
                }

            }

            CheckTujuan("");
        </script>
    </form>
</body>
</html>
