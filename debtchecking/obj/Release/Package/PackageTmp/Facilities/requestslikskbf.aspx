<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="requestslikskbf.aspx.cs" Inherits="DebtChecking.Facilities.requestslikskbf" EnableEventValidation="false" %>


<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register Src="../CommonForm/UC_UploadedFile.ascx" TagName="UC_UploadedFile" TagPrefix="uc3" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <Template:Admin runat="server" ID="Template" />

    <title></title>
    <style>
        ul {
            list-style-type: none;
        }

        label {
            margin-bottom: 0;
        }

        .hidden {
            display: none;
        }
    </style>
    <script type="text/javascript" language="javascript">

        function setoverlaypage() {
            $('#overlaypage').attr("class", "overlay");
        }

        function removerlaypage() {
            $('#overlaypage').attr("class", "hidden");
        }

        function saveData() {
            if (validasiktp() && $('#form1').valid()) {
                $('#flagShowMyModalFoto').val('true');
                $('#flagShowMyModalSLIKLainnya').val('true');
                setoverlaypage();
                callback(mainPanel, 's');
            }
        }
        function submitData() {
            if (validasiktp() && $('#form1').valid()) {
                $('#flagShowMyModalFoto').val('true');
                $('#flagShowMyModalSLIKLainnya').val('true');
                var answer = confirm('Pastikan data yang diinput sudah benar!');
                if (answer) {
                    setoverlaypage();
                    callback(mainPanel, 'submit')
                }
                else {
                    return false;
                }
            }
        }
        function deleteData() {
            if (confirm('Hapus data permintaan SLIK checking?')) {
                $('#flagShowMyModalFoto').val('true');
                $('#flagShowMyModalSLIKLainnya').val('true');
                setoverlaypage();
                callback(mainPanel, 'd');
            }
        }

        //if (cust_type.SelectedValue == "PSH") {
        //    tr_gender.Style["display"] = "none";
        //    tr_mother_name.Style["display"] = "none";
        //    npwp.CssClass = "form-control form-control-sm mandatory";
        //    gender.CssClass = "form-control form-control-sm border-0 text-sm";
        //}
        //else {
        //    tr_gender.Style["display"] = "";
        //    tr_mother_name.Style["display"] = "";
        //    npwp.CssClass = "form-control form-control-sm";
        //    gender.CssClass = "form-control form-control-sm mandatory border-0 text-sm";
        //}
        //$(window).on("load", function () {
        //    if (document.getElementById("mainPanel_cust_type_0").checked) {
        //        ubahjenis("IND");
        //    }
        //    if (document.getElementById("mainPanel_cust_type_1").checked) {
        //        ubahjenis("PSH");
        //    }
        //});

        //$("#mainPanel_gridPanel_GridFileUpload").DataTable();

        function uploadDokumen() {
            if ("<%=Request.QueryString["requestid"] %>" == "") {
                alert('Tekan Save Untuk Menambahkan Dokumen');
                $('#flagShowMyModalFoto').val('true');
                $('#myModal').modal('hide');
                return false;
            } else {
                $('#flagShowMyModalFoto').val('false');
            }

        }
        function ubahjenis(val) {
            if (val == "IND") {
                document.getElementById("mainPanel_npwp").setAttribute("class", "form-control form-control-sm");
                document.getElementById("mainPanel_gender").setAttribute("class", "form-control form-control-sm border-0 text-sm mandatory");
                document.getElementById("tr_gender").style.display = "";
                document.getElementById("mainPanel_tr_mother_name").style.display = "";

            } else if (val == "PSH") {
                document.getElementById("mainPanel_npwp").setAttribute("class", "form-control form-control-sm mandatory");
                document.getElementById("mainPanel_gender").setAttribute("class", "form-control form-control-sm border-0 text-sm");
                document.getElementById("tr_gender").style.display = "none";
                document.getElementById("mainPanel_tr_mother_name").style.display = "none";
            }
        }
        function ubahjenis_supl(val) {
            if (val == "IND") {
                document.getElementById("mainPanel_supp_npwp").setAttribute("class", "form-control form-control-sm");
                document.getElementById("mainPanel_supp_gender").setAttribute("class", "form-control form-control-sm border-0 text-sm mandatory");
                document.getElementById("mainPanel_tr_supp_gender").style.display = "";
                document.getElementById("mainPanel_tr_supp_mother_name").style.display = "";

            } else if (val == "PSH") {
                document.getElementById("mainPanel_supp_npwp").setAttribute("class", "form-control form-control-sm mandatory");
                document.getElementById("mainPanel_supp_gender").setAttribute("class", "form-control form-control-sm border-0 text-sm");
                document.getElementById("mainPanel_tr_supp_gender").style.display = "none";
                document.getElementById("mainPanel_tr_supp_mother_name").style.display = "none";
            }
        }

        function validasiktp() {
            var ret = true
            var noktp = document.getElementById("mainPanel_ktp").value;
            var nonpwp = document.getElementById("mainPanel_npwp").value;
            if (document.getElementById("mainPanel_cust_type_0").checked) {
                if (noktp.length < 10) {
                    alert("No KTP tidak valid!");
                    ret = false;
                }
            }
            if (document.getElementById("mainPanel_cust_type_1").checked) {
                if (nonpwp.length < 15) {
                    alert("No NPWP tidak valid!");
                    ret = false;
                }
            }
            return ret
        }

        function validasiktp_supl() {
            var ret = true;
            var noktp = document.getElementById("mainPanel_supp_ktp").value;
            var nonpwp = document.getElementById("mainPanel_supp_npwp").value;

            if (
                document.getElementById("mainPanel_supp_cust_type_0").checked ||
                document.getElementById("mainPanel_supp_cust_type_1").checked
            ) {
                if (document.getElementById("mainPanel_supp_cust_type_0").checked) {
                    if (noktp.length < 10) {
                        alert("No KTP tidak valid!");
                        ret = false;
                    }
                }
                if (document.getElementById("mainPanel_supp_cust_type_1").checked) {
                    if (nonpwp.length < 15) {
                        alert("No NPWP tidak valid!");
                        ret = false;
                    }
                }
            } else {
                alert("Pilih Jenis Nasabah!");
                ret = false;
            }
            return ret
        }

        function saveSupl() {
            if (validasiktp_supl()) {
                callback(gridSuppPanel, 's:');
                $('#myModalSLIKLainnya').modal('hide');
            }
        }

        function showModal() {

            if ($('#flagShowMyModalFoto').val() != 'true') {
                $('#myModal').modal('show');
            } else {
                if ($("#<%=seq.ClientID%>").val() != '' && $('#flagShowMyModalSLIKLainnya').val() != 'true') {
                    $('#myModalSLIKLainnya').modal('show');

                    if (document.getElementById('mainPanel_supp_cust_type_0').checked) {
                        ubahjenis_supl('IND');
                    }
                    if (document.getElementById('mainPanel_supp_cust_type_1').checked) {
                        ubahjenis_supl('PSH');
                    }
                    //Date picker
                    $('.date').daterangepicker({
                        singleDatePicker: true,
                        showDropdowns: true,
                        minYear: 1901,
                        maxYear: parseInt(moment().format('YYYY'), 10),
                        locale: {
                            format: 'DD MMMM YYYY'
                        }
                    })
                }
            }
        }

        function changeDocCode() {
            $('#<%=h_DOC_CODE.ClientID %>').val('<%#DOC_CODE.SelectedValue %>');
        }


        $(document).ready(function () {
            $('select').select2({
                theme: 'bootstrap4'
            })





            $(document).on("click", ".gdownload", function () {
                var docid = $(this).data('docid');
                console.log(docid);
                gridPanel.PerformCallback('r:' + docid);
            });

            $(document).on("click", ".gdelete", function () {
                var docid = $(this).data('docid');
                console.log(docid);
                if (confirm('Are You Sure ? ')) {
                    gridPanel.PerformCallback('d:' + docid);
                }
            });

            $(document).on("click", ".open-myModalSLIKLainnya", function () {
                if ("<%=Request.QueryString["requestid"] %>" == "") {
                    alert('Tekan Save Untuk Menambahkan Dokumen');
                } else {

                    $('#myModalSLIKLainnya').modal('show');
                    $("#<%=seq.ClientID%>").val('');
                    document.getElementById("mainPanel_supp_cust_name").value = "";
                    document.getElementById("mainPanel_supp_dob").value = "";
                    document.getElementById("mainPanel_supp_ktp").value = "";
                    document.getElementById("mainPanel_supp_npwp").value = "";
                    document.getElementById("mainPanel_supp_phonenumber").value = "";
                    document.getElementById("mainPanel_supp_homeaddress").value = "";
                    document.getElementById("mainPanel_supp_mother_name").value = "";
                    document.getElementById("mainPanel_supp_pob").value = "";
                    $('#mainPanel_status_app').val([])
                    $('#mainPanel_supp_cust_type_0').val([])
                    $('#mainPanel_supp_cust_type_1').val([])
                    $('#mainPanel_supp_gender_0').val([])
                    $('#mainPanel_supp_gender_1').val([])
                }
            });

            $(document).on("click", ".supp_edit", function () {
                var id = $(this).data('id');
                $('#flagShowMyModalFoto').val('true');
                $('#flagShowMyModalSLIKLainnya').val('false');

                mainPanel.PerformCallback('gp:' + id);
            });

            $(document).on("click", ".supp_delete", function () {
                var id = $(this).data('id');
                if (confirm('Are You Sure ? ')) {
                    callback(gridSuppPanel, 'd:' + id);
                }
            });

            $(document).on("click", ".open-myModal", function () {
                var docid = $(this).data('docid');
                var doccode = $(this).data('doccode');
                var notes = $(this).data('notes');
                var div = document.getElementById('docothers');

                callback(mainPanel, "rfoto:" + docid + ":" + doccode + ":" + notes + ":" + div);

                uploadDokumen();
                $(".combobox-container").removeClass('combobox-selected');
            });


        });
    </script>
</head>
<body class="text-sm">
    <form id="form1" runat="server" autocomplete="off">
        <input type="hidden" name="name" id="flagShowMyModalFoto" />
        <input type="hidden" name="name" id="flagShowMyModalSLIKLainnya" />
        <div class="container-fluid">
            <dx:ASPxCallbackPanel ID="mainPanel" runat="server" Width="100%" BackColor="Transparent"
                ClientInstanceName="mainPanel" OnCallback="mainPanel_Callback">
                <ClientSideEvents EndCallback="function(s,e) {
                    removerlaypage();
                    //Date picker
                    $('.date').daterangepicker({
                        singleDatePicker: true,
                        showDropdowns: true,
                        minYear: 1901,
                        maxYear: parseInt(moment().format('YYYY'), 10),
                        locale: {
                            format: 'DD MMMM YYYY'
                        }
                    })

                    showModal(); }" />

                <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server">
                        <input type="hidden" id="seq" runat="server" />
                        <div class="card card-primary card-outline">
                            <div class="card-header">
                                <h4 class="card-title">Request SLIK checking</h4>
                            </div>
                            <!-- /.card-header -->

                            <div class="card-body">
                                <div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Request ID</label>
                                                <div class="col-sm-8">
                                                    <asp:Label ID="requestid" runat="server" CssClass="form-control form-control-sm"></asp:Label>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Jenis Customer</label>
                                                <div class="col-sm-8">
                                                    <asp:RadioButtonList ID="cust_type" Enabled="false" RepeatLayout="UnorderedList" CssClass="form-control form-control-sm border-0 text-sm" runat="server" RepeatDirection="Vertical">
                                                        <asp:ListItem Text="Individu" Value="IND"></asp:ListItem>
                                                        <asp:ListItem Text="Perusahaan" Value="PSH"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Produk</label>
                                                <div class="col-sm-8">
                                                    <asp:DropDownList ID="productid" runat="server" CssClass="form-control form-control-sm input-sm autofillflag" onchange="panelDealer.PerformCallback();panelLoanTerm.PerformCallback();"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Cabang</label>
                                                <div class="col-sm-8">
                                                    <asp:DropDownList ID="branchid" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Tujuan SLIK Checking</label>
                                                <div class="col-sm-8">
                                                    <asp:DropDownList ID="purpose" onchange="CheckTujuan(this.value);" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <h6>Informasi Debitur</h6>
                                    <hr />
                                    <div class="row">
                                        <div class="col-sm-6">

                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Nomor Aplikasi</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="NoAplikasi" runat="server" CssClass="form-control form-control-sm" data-info="Nomor Aplikasi"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Nama Customer</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="cust_name" runat="server" CssClass="form-control form-control-sm" MaxLength="100"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Nomor KTP / Akta</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="ktp" runat="server" CssClass="form-control form-control-sm" MaxLength="16" onkeypress="return digitsonly();" onpaste="if(parseInt(clipboardData.getData('Text')) != clipboardData.getData('Text')) return false;"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Nomor NPWP</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="npwp" runat="server" CssClass="form-control form-control-sm" MaxLength="20" onkeypress="return digitsonly();" onpaste="if(parseInt(clipboardData.getData('Text')) != clipboardData.getData('Text')) return false;"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group row" runat="server" id="tr_gender">
                                                <label class="col-sm-4 col-form-label">Jenis Kelamin</label>
                                                <div class="col-sm-8">
                                                    <asp:RadioButtonList ID="gender" RepeatLayout="UnorderedList" RepeatDirection="Vertical" CssClass="form-control form-control-sm border-0 text-sm" runat="server">
                                                        <asp:ListItem Text="Laki-laki" Value="M"></asp:ListItem>
                                                        <asp:ListItem Text="Perempuan" Value="F"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                            <%--<div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Status BPKB</label>
                                                <div class="col-sm-8">
                                                    <asp:RadioButtonList ID="status_bpkb" RepeatLayout="UnorderedList" RepeatDirection="Vertical" ClientIDMode="Static" CssClass="form-control form-control-sm border-0 text-sm" runat="server">
                                                        <asp:ListItem Text="Sendiri" Value="SENDIRI"></asp:ListItem>
                                                        <asp:ListItem Text="Orang Lain" Value="ORANG_LAIN"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Nama BPKB</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="nama_bpkb" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                                </div>
                                            </div>--%>
                                        </div>
                                        <div class="col-sm-6">


                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Tempat Lahir/Pendirian</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="pob" CssClass="form-control form-control-sm" runat="server" MaxLength="50"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Tgl Lahir/Pendirian</label>
                                                <div class="col-sm-8">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                        <asp:TextBox ID="dob" runat="server" autocomplete="off" ClientIDMode="Static" CssClass="form-control form-control-sm pull-right date"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group row" runat="server" id="tr_mother_name">
                                                <label class="col-sm-4 col-form-label">Nama Ibu Kandung</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="mother_name" CssClass="form-control form-control-sm" runat="server" MaxLength="50"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row hidden">
                                                <label class="col-sm-4 col-form-label">Alamat</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="homeaddress" CssClass="form-control form-control-sm" runat="server" TextMode="MultiLine" Rows="2" MaxLength="250"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Nomor Telp</label>
                                                <div class="col-sm-8">
                                                    <asp:TextBox ID="phonenumber" CssClass="form-control form-control-sm" runat="server" MaxLength="15" onkeypress="return digitsonly();" onpaste="if(parseInt(clipboardData.getData('Text')) != clipboardData.getData('Text')) return false;"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <h6>Permintaan SLIK Checking Lainnya/Tambahan</h6>
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <%--onclick="callbackpopup(PopupSID, PanelSID, 'r:')"--%>
                                        <button id="AddSLIKCHeckingLainnya" type="button"
                                            class="open-myModalSLIKLainnya btn btn-xs btn-success" data-id="">
                                            <i class="fa fa-plus" aria-hidden="true"></i>&nbsp Tambah</button>
                                    </div>
                                </div>
                                <hr />
                                <div>
                                    <div class="row">
                                        <div class="col-sm-12 col-sm-offset-4">

                                            <div>

                                                <div>
                                                    <div class="modal fade" id="myModalSLIKLainnya" role="dialog">
                                                        <div class="modal-dialog modal-xl">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="Label">Permintaan SLIK Checking Lainnya</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <div class="modal-body">
                                                                            <div class="form-horizontal">
                                                                                <div class="container">
                                                                                    <div class="row">
                                                                                        <div class="col-sm-6">
                                                                                            <div>
                                                                                                <div class="form-group row">
                                                                                                    <label class="col-sm-4 col-form-label">Jenis</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:RadioButtonList ID="supp_cust_type" runat="server" RepeatLayout="UnorderedList" RepeatDirection="Vertical" CssClass="form-control form-control-sm border-0 text-sm">
                                                                                                            <asp:ListItem Text="Individu" Value="IND" onclick="ubahjenis_supl(this.value)"></asp:ListItem>
                                                                                                            <asp:ListItem Text="Perusahaan" Value="PSH" onclick="ubahjenis_supl(this.value)"></asp:ListItem>
                                                                                                        </asp:RadioButtonList>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group row">
                                                                                                    <label class="col-sm-4 col-form-label">Hubungan</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:DropDownList ID="status_app" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group row">
                                                                                                    <label class="col-sm-4 col-form-label">Nama Customer</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="supp_cust_name" runat="server" CssClass="form-control form-control-sm" MaxLength="100"></asp:TextBox>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group row">
                                                                                                    <label class="col-sm-4 col-form-label">Nomor KTP / Akta</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="supp_ktp" runat="server" CssClass="form-control form-control-sm" MaxLength="20" onkeypress="return digitsonly();" onpaste="if(parseInt(clipboardData.getData('Text')) != clipboardData.getData('Text')) return false;"></asp:TextBox>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group row">
                                                                                                    <label class="col-sm-4 col-form-label">Nomor NPWP</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="supp_npwp" CssClass="form-control form-control-sm" runat="server" MaxLength="20" onkeypress="return digitsonly();" onpaste="if(parseInt(clipboardData.getData('Text')) != clipboardData.getData('Text')) return false;">
                                                                                                        </asp:TextBox>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-sm-6">
                                                                                            <div>
                                                                                                <div class="form-group row">
                                                                                                    <label class="col-sm-5 col-form-label">Tempat Lahir/Pendirian</label>
                                                                                                    <div class="col-sm-7">
                                                                                                        <asp:TextBox ID="supp_pob" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                                                                                    </div>
                                                                                                </div>

                                                                                                <div class="form-group row">
                                                                                                    <label class="col-sm-5 col-form-label">Tgl Lahir/Pendirian</label>
                                                                                                    <div class="col-sm-7">
                                                                                                        <div class="input-group">
                                                                                                            <div class="input-group-addon">
                                                                                                                <i class="fa fa-calendar"></i>
                                                                                                            </div>
                                                                                                            <asp:TextBox ID="supp_dob" runat="server" CssClass="form-control form-control-sm pull-right date"></asp:TextBox>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div id="tr_supp_gender" class="form-group row" runat="server">
                                                                                                    <label class="col-sm-5 col-form-label">Jenis Kelamin</label>
                                                                                                    <div class="col-sm-7">
                                                                                                        <asp:RadioButtonList ID="supp_gender" RepeatLayout="UnorderedList" CssClass="form-control form-control-sm border-0 text-sm" runat="server" RepeatDirection="Vertical">
                                                                                                            <asp:ListItem Text="Laki-laki" Value="M"></asp:ListItem>
                                                                                                            <asp:ListItem Text="Perempuan" Value="F"></asp:ListItem>
                                                                                                        </asp:RadioButtonList>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div id="tr_supp_mother_name" class="form-group row" runat="server">
                                                                                                    <label class="col-sm-5 col-form-label">Nama Ibu Kandung</label>
                                                                                                    <div class="col-sm-7">
                                                                                                        <asp:TextBox ID="supp_mother_name" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group row hidden">
                                                                                                    <label class="col-sm-5 col-form-label">Alamat</label>
                                                                                                    <div class="col-sm-7">
                                                                                                        <asp:TextBox ID="supp_homeaddress" runat="server" CssClass="form-control form-control-sm" TextMode="MultiLine" Rows="2" MaxLength="250"></asp:TextBox>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group row hidden">
                                                                                                    <label class="col-sm-5 col-form-label">Nomor Telp</label>
                                                                                                    <div class="col-sm-7">
                                                                                                        <asp:TextBox ID="supp_phonenumber" runat="server" CssClass="form-control form-control-sm" MaxLength="15" onkeypress="return digitsonly();" onpaste="if(parseInt(clipboardData.getData('Text')) != clipboardData.getData('Text')) return false;"></asp:TextBox>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div align="center" colspan="2">
                                                                                            <input runat="server" id="BTN_SAVE1" type="button" class="m-1 btn btn-primary"
                                                                                                onclick="saveSupl()" value=" Save" />
                                                                                            <%--<input id="BTN_CANCEL1" runat="server" class="m-1 btn btn-default" type="button" value="Cancel" />--%>

                                                                                            <%--     <input runat="server" id="BTN_SAVE1" type="button" class="m-1 btn btn-primary"
                                                                                        onclick="if (validasiktp_supl()) callbackpopup(PopupSID, PanelSID, 's:', GridViewSuppl);" value=" Save " />
                                                                                    <input id="BTN_CANCEL1" runat="server" class="m-1 btn btn-default"
                                                                                        onclick="PopupSID.Hide();" type="button" value="Cancel" />
                                                                                    <input type="hidden" id="seq" runat="server" />--%>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <dx:ASPxCallbackPanel runat="server" ID="gridSuppPanel" ClientInstanceName="gridSuppPanel" OnCallback="gridSuppPanel_Callback">
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
                                                            debugger
                                                        }" />

                                                    <PanelCollection>

                                                        <dx:PanelContent ID="PanelContent3" runat="server">

                                                            <asp:GridView ID="GridViewSuppl" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found!"
                                                                CssClass="table table-striped table-bordered table-hover">
                                                                <Columns>
                                                                    <asp:BoundField DataField="Nomor" HeaderText="No" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                                    <asp:BoundField DataField="cust_name" HeaderText="Nama Customer" />
                                                                    <asp:BoundField DataField="CustType" HeaderText="Jenis Customer" />
                                                                    <asp:BoundField DataField="TempatLahir" HeaderText="Tempat Lahir/Pendirian" />
                                                                    <asp:BoundField DataField="TglLahir" HeaderText="Tanggal Lahir/Pendirian" />
                                                                    <asp:BoundField DataField="status_app" HeaderText="Hubungan" />
                                                                    <asp:TemplateField>
                                                                        <ItemStyle Width="15%"></ItemStyle>
                                                                        <ItemTemplate>
                                                                            <a id="supp_edit" runat="server" data-toggle="tooltip"
                                                                                data-id='<%# Eval("seq") %>'
                                                                                class="supp_edit btn btn-xs btn-danger">
                                                                                <i class="fa fa-pen" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a id="supp_delete" runat="server" data-toggle="tooltip"
                                                                                data-id='<%# Eval("seq") %>'
                                                                                class="supp_delete btn btn-xs btn-danger">
                                                                                <i class="fa fa-times" aria-hidden="true"></i>
                                                                            </a>
                                                                            <%--                                                                    <input type="button" value="Edit" onclick="callbackpopup(PopupSID, PanelSID, 'r:' +)" />
                                                                    <input type="button" value="Delete" onclick="if (confirm('Hapus data?')) callback(GridViewSuppl, 'd:' + <%# Container.KeyValue %>)" />--%>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <h6>Dokumen</h6>
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <button id="btn_upload" runat="server" type="button" class="open-myModal btn btn-xs btn-success pull-right" data-docid="" data-doccode="">
                                            <i class="fa fa-plus" aria-hidden="true"></i>&nbsp Tambah</button>
                                    </div>
                                </div>
                                <hr />
                                <div>

                                    <!-- Row start -->
                                    <div class="row">
                                        <div class="col-sm-12">

                                            <!-- .modal -->
                                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="myModalLabel">Upload File</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <fieldset>
                                                                    <div class="modal-body">
                                                                        <div class="form-horizontal" role="form">
                                                                            <div class="form-group row">
                                                                                <label class="col-sm-4 col-form-label">Document Type</label>
                                                                                <div class="col-sm-8">
                                                                                    <asp:DropDownList runat="server" ID="DOC_CODE" CssClass="form-control form-control-sm input-sm" onchange="changeDocCode()" />
                                                                                    <input type="hidden" runat="server" id="h_DOC_ID" />
                                                                                    <input type="hidden" runat="server" id="h_DOC_CODE" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group row" id="docothers">
                                                                                <label class="col-sm-4 col-form-label">Document Description</label>
                                                                                <div class="col-sm-8">
                                                                                    <asp:TextBox runat="server" ID="DOC_OTHER" CssClass="form-control form-control-sm input-sm"></asp:TextBox>
                                                                                </div>
                                                                            </div>

                                                                            <div class="form-group row">
                                                                                <label class="col-sm-4 col-form-label">Upload File</label>

                                                                                <div class="col-sm-8">
                                                                                    <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" ClientInstanceName="upload" ShowProgressPanel="true" ShowUploadButton="false" FileUploadMode="OnPageLoad"
                                                                                        Width="300" OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete">
                                                                                        <AdvancedModeSettings EnableFileList="False" EnableDragAndDrop="True" />
                                                                                        <ValidationSettings MaxFileSize="3145728" />
                                                                                        <ClientSideEvents FileUploadComplete="function(s, e) {

                                                            $('#myModal').modal('hide');
                                                            gridPanel.PerformCallback('u:' + e.callbackData);
                                                            }" />
                                                                                    </dx:ASPxUploadControl>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <div id="div_upload" style="display: none">
                                                                            <dx:ASPxButton ID="btnUpload" runat="server" AutoPostBack="False"
                                                                                Text="Upload" ClientInstanceName="btnUpload" CssClass="btn btn-success" formnovalidate>
                                                                                <ClientSideEvents Click="function(s, e) { this. upload.UploadFile(); }"></ClientSideEvents>
                                                                                <%--event.preventDefault();--%>
                                                                            </dx:ASPxButton>
                                                                        </div>
                                                                        <button class="btn btn-success" id="btn_help_upload" type="button"
                                                                            onclick=" $('#btn_help_upload').attr('disabled',''); $('#mainPanel_btnUpload_I').click();  $('#btn_help_upload').removeAttr('disabled'); ">
                                                                            Upload
                                                                        </button>
                                                                    </div>
                                                                </fieldset>
                                                            </div>
                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>
                                                    <!-- /.modal-dialog -->
                                                </div>
                                                <!-- /.modal -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-sm-12">

                                            <div class="table-responsive">

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
                                                            CheckTujuan('');
                                                        
                                                            $('select').select2({
                                                                theme: 'bootstrap4'
                                                            })
                                                        }" />
                                                    <PanelCollection>
                                                        <dx:PanelContent ID="PanelContent9" runat="server">
                                                            <asp:GridView ID="GridFileUpload" ShowHeaderWhenEmpty="true" EmptyDataText="No records Found!" runat="server" Width="100%" CssClass="datatables table table-striped table-bordered table-hover"
                                                                AutoGenerateColumns="False"
                                                                AllowPaging="True"
                                                                PageSize="10"
                                                                OnPageIndexChanged="GridFileUpload_PageIndexChanged"
                                                                OnPageIndexChanging="GridFileUpload_PageIndexChanging"
                                                                OnRowDataBound="GridFileUpload_RowDataBound">
                                                                <PagerStyle HorizontalAlign="Right" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Terunggah">
                                                                        <ItemTemplate>
                                                                            <input type="checkbox" id="cbUPLOADED" runat="server" data-uploaded='<%# Eval("UPLOADED") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="DOC_DESC" HeaderText="Document Type" />
                                                                    <asp:BoundField DataField="DOC_OTHER" HeaderText="Deskripsi" />
                                                                    <%--<asp:BoundField DataField="DOC_NAME" HeaderText="File Name" HeaderStyle-CssClass="hidden-xs" ItemStyle-CssClass="hidden-xs" />--%>
                                                                    <asp:BoundField DataField="UPLOAD_BY" HeaderText="Upload By" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                                    <asp:BoundField DataField="UPLOAD_DATE" HeaderText="Upload Date" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                                    <asp:BoundField DataField="GEOTAG_ADDRESS" HeaderText="Upload Location" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                                    <asp:TemplateField HeaderText="Function">
                                                                        <ItemStyle Width="10%"></ItemStyle>
                                                                        <ItemTemplate>
                                                                            <span data-toggle="tooltip" title="Upload File">
                                                                                <a id="lnkUpload" runat="server" data-toggle="modal"
                                                                                    data-docid='<%# Eval("DOC_ID") %>'
                                                                                    data-doccode='<%# Eval("DOC_CODE") %>'
                                                                                    data-notes='<%# Eval("DOC_OTHER") %>'
                                                                                    data-allowupload='<%# Eval("ALLOWUPLOAD") %>'
                                                                                    class="open-myModal btn btn-xs btn-primary">
                                                                                    <i class="fa fa-upload" aria-hidden="true"></i>
                                                                                </a>
                                                                            </span>
                                                                            <a id="lnkDownload" runat="server" data-toggle="tooltip" title="View File"
                                                                                data-docid='<%# Eval("DOC_ID") %>'
                                                                                data-uploadby='<%# Eval("UPLOAD_BY") %>'
                                                                                class="gdownload btn btn-xs btn-success">
                                                                                <i class="fa fa-eye" aria-hidden="true" title="view"></i>
                                                                            </a>
                                                                            <a id="lnkDelete" runat="server" data-toggle="tooltip" title="Delete File"
                                                                                data-docid='<%# Eval("DOC_ID") %>'
                                                                                data-docman='<%# Eval("DOC_MAN") %>'
                                                                                data-allowdelete='<%# Eval("ALLOWDELETE") %>'
                                                                                class="gdelete btn btn-xs btn-danger">
                                                                                <i class="fa fa-times" aria-hidden="true"></i>
                                                                            </a>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </dx:PanelContent>
                                                    </PanelCollection>
                                                </dx:ASPxCallbackPanel>
                                            </div>
                                            <!-- Row end -->
                                        </div>
                                    </div>

                                </div>



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


                                                                    <dx:ASPxCallbackPanel runat="server" ID="panelDealer" ClientInstanceName="panelDealer" OnCallback="panelDealer_Callback">
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
                                <!-- /.card-body -->
                                <div class="card-footer">
                                    <div>
                                        <div align="center">
                                            <input type="button" id="btn_save" runat="server" value="Save" class="m-1 btn btn-primary" onclick="saveData();" />
                                            <input type="button" id="btn_del" runat="server" value="Delete" class="m-1 btn btn-danger" onclick="deleteData();" />
                                            <button type="submit" id="btn_submit" class="m-1 btn btn-success" onclick="submitData();">
                                                Submit</button>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.card-footer -->
                                <hr />
                                <div width="100%" id="tbl_history" runat="server" style="display: none">
                                    <div class="row">
                                        <div class="col-sm-12"><b>History</b></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <asp:GridView ID="GRID_NOTES" runat="server" Width="100%" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                <FooterStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <AlternatingRowStyle />
                                                <RowStyle ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
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
                            </div>

                            <div id="overlaypage" class="hidden">
                                <i class="fas fa-2x fa-sync-alt"></i>
                            </div>
                            <br />
                        </div>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>

            <dx:ASPxPopupControl ID="PopFindExisting" ClientInstanceName="PopFindExisting" runat="server" ShowHeader="false" Width="750px"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" BackColor="Transparent"
                CloseAction="CloseButton" Modal="True" AllowDragging="True">
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                        <dx:ASPxCallbackPanel ID="PNL_FindExisting" runat="server" ClientInstanceName="PNL_FindExisting" OnCallback="PNL_FindExisting_Callback">
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent2" runat="server">
                                    <div class="card card-primary card-outline">
                                        <div class="card-header">
                                            <h3 class="card-title">Pencarian Data Existing</h3>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <table class="table table-sm table-borderless ">
                                                <tr>
                                                    <td>
                                                        <table class="table table-sm">
                                                            <tr>
                                                                <td class="B01">Nama Customer</td>
                                                                <td class="B11">
                                                                    <asp:TextBox ID="find_name" CssClass="form-control form-control-sm" runat="server" Width="200px" MaxLength="100" onkeydown="if (event.keyCode == 13) { callback(PNL_FindExisting, 'f:'); }"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td class="B01">Atau Requestid</td>
                                                                <td class="B11">
                                                                    <asp:TextBox ID="find_reqid" CssClass="form-control form-control-sm" runat="server" Width="200px" MaxLength="20" onkeydown="if (event.keyCode == 13) { callback(PNL_FindExisting, 'f:'); }"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td class="B01">&nbsp;</td>
                                                                <td class="B11">
                                                                    <input type="button" value="Cari" class="btn btn-primary" onclick="callback(PNL_FindExisting, 'f:');" /></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:GridView ID="GridFind" runat="server" Width="100%" CssClass="table table-bordered" AutoGenerateColumns="false" ShowHeader="true">
                                                            <FooterStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            <HeaderStyle Font-Bold="true" ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            <AlternatingRowStyle />
                                                            <RowStyle ForeColor="black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            <Columns>
                                                                <asp:BoundField DataField="cust_name" HeaderText="Nama" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="20%" />
                                                                <asp:BoundField DataField="ktp" HeaderText="No KTP" ItemStyle-HorizontalAlign="left" ItemStyle-Width="15%" />
                                                                <asp:TemplateField HeaderText="Tgl Lahir" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="12%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbl3" runat="server" Text='<%#FormatedValue(Eval("inputdate"),"dd/MM/yyyy")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="npwp" HeaderText="NPWP" ItemStyle-HorizontalAlign="left" ItemStyle-Width="12%" />
                                                                <asp:TemplateField HeaderText="Tgl Input" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="12%">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbl3" runat="server" Text='<%#FormatedValue(Eval("inputdate"),"dd/MM/yyyy")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10%">
                                                                    <ItemTemplate>
                                                                        <input type="button" id="btn3" runat="server" value="Ambil" commandargument='<%# Eval("requestid") %>'
                                                                            onclick="callbackpopup(PopFindExisting, PNL_FindExisting, 'f:', mainPanel, 'g:' + this.commandargument);" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="10%">
                                                                    <ItemTemplate>
                                                                        <input type="button" id="Button6" runat="server" value="Ambil 2" commandargument='<%# Eval("requestid") %>'
                                                                            onclick="callbackpopup(PopFindExisting, PNL_FindExisting, 'fp:', PanelSID, 'gp:' + this.commandargument);" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                        <asp:Label ID="lblnotfound" runat="server" ForeColor="Red" Font-Bold="true" Visible="false" Text="Data tidak ditemukan"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <input id="Button5" runat="server" class="btn btn-default" onclick="PopFindExisting.Hide();" type="button" value="Cancel" />
                                                        <input type="hidden" id="searchsup" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                    <!-- /.card -->
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
                    val = $('#mainPanel_purpose').val();
                }
                if (val == "1") {
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
