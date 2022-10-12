<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Template.ascx.cs" Inherits="MikroMnt.include.Template" %>
<!-- Font Awesome -->
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/fontawesome-free/css/all.min.css") %>'>
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bbootstrap 4 -->
<%--<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css") %>'>--%>
<!-- iCheck -->
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/icheck-bootstrap/icheck-bootstrap.min.css")%>'>
<!-- JQVMap -->
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/jqvmap/jqvmap.min.css")%>'>
<!-- Theme style -->
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/dist/css/adminlte.min.css")%>'>

<%--<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css")%>'>--%>
<!-- overlayScrollbars -->
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/overlayScrollbars/css/OverlayScrollbars.min.css")%>'>

<link href='<%= ResolveUrl("~/App_Themes/mwstyle/dataTables/datatables.css")%>' rel="stylesheet" />

<link href='<%= ResolveUrl("~/App_Themes/mwstyle/dataTables/Buttons-1.6.1/css/buttons.dataTables.css")%>' rel="stylesheet" />

<link href='<%= ResolveUrl("~/App_Themes/mwstyle/dataTables/datatables.min.css")%>' rel="stylesheet" />

<!-- Daterange picker -->
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/daterangepicker/daterangepicker.css")%>'>
<!-- summernote -->
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/summernote/summernote-bs4.css")%>'>
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/select2/css/select2.min.css")%>'>
<link rel="stylesheet" href='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css")%>'>
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

<link rel="stylesheet" href="<%= ResolveUrl("~/include/bootstrap-combobox.css") %>">

<style>
    a, button {
        cursor: pointer !important;
    }

    hr {
        margin-top: 5px !important;
        margin-bottom: 5px !important;
        border: 1px solid #bfbdbd;
    }

    th {
        border-top: 1px solid #dddddd !important;
        border-bottom: 1px solid #dddddd !important;
        border-right: 1px solid #dddddd !important;
    }

        th:first-child {
            border-left: 1px solid #dddddd !important;
        }

    .card {
        margin-top: 5px !important;
    }

    .card-header {
        padding: .5rem !important;
    }

    .card-body {
        padding: .5rem !important;
    }

    .card-footer {
        padding: .5rem !important;
    }

    .modal {
        margin-top: 5px !important;
    }

    .modal-header {
        padding: .5rem !important;
    }

    .modal-body {
        padding: .5rem !important;
    }

    .modal-footer {
        padding: .5rem !important;
    }

    .holds-the-iframe {
        background: url('image/windy_loading_blue_sky.gif') center center no-repeat;
        background-size: 5%;
        min-height: 400px;
    }

    input[type=text], input[type=number], textarea {
        text-transform: uppercase;
    }

    .nav-item {
        cursor: pointer !important;
    }
</style>

<!-- jQuery -->
<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/jquery/jquery.min.js")%>'></script>
<!-- jQuery UI 1.11.4 -->
<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/jquery-ui/jquery-ui.min.js")%>'></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
    $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/bootstrap/js/bootstrap.bundle.min.js")%>'></script>

<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/moment/moment.min.js")%>'></script>
<!-- daterangepicker -->
<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/daterangepicker/daterangepicker.js")%>'></script>

<%--<script src='<%= ResolveUrl("~/App_Themes/mwstyle/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js")%>'></script>--%>
<!-- Tempusdominus Bootstrap 4 -->
<%--<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js")%>'></script>--%>
<!-- Summernote -->
<%--<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/summernote/summernote-bs4.min.js")%>'></script>--%>
<!-- overlayScrollbars -->
<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js")%>'></script>

<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/jquery-validation/jquery.validate.min.js")%>'></script>

<script src='<%= ResolveUrl("~/App_Themes/mwstyle/dataTables/datatables.min.js")%>'></script>

<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/datatables-responsive/js/dataTables.responsive.js")%>'></script>

<script src='<%= ResolveUrl("~/App_Themes/mwstyle/dist/js/adminlte.js")%>'></script>

<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/chart.js/Chart.min.js")%>'></script>

<script src='<%= ResolveUrl("~/App_Themes/mwstyle/plugins/select2/js/select2.full.min.js")%>'></script>

<script src="<%= ResolveUrl("~/include/bootstrap-combobox.js") %>"></script>

<script src="<%= ResolveUrl("~/library/MWSTools.js") %>"></script>





<script src="<%= ResolveUrl("~/include/onepost.js") %>"></script>

<script src="<%= ResolveUrl("~/include/cek_entries.js") %>"></script>

<script>

    $(document).ready(function () {

        $('.numeric').on('keypress', function () {
            $(this).val();
        });



        $('.combobox').combobox();

        //Date
        $('.date').daterangepicker({
            autoUpdateInput: false,
            singleDatePicker: true,
            showDropdowns: true,
            minDate: 1,
            minYear: 1901,
            maxYear: parseInt(moment().format('YYYY'), 10),
            locale: {
                format: 'DD MMMM YYYY'
            }
        })

        //Date
        $('.daterange').daterangepicker({
            autoUpdateInput: false,
            showDropdowns: true,
            minDate: 1,
            minYear: 1901,
            maxYear: parseInt(moment().format('YYYY'), 10),
            locale: {
                format: 'DD MMMM YYYY'
            }
        })

        $('.date').on('apply.daterangepicker', function (ev, picker) {
            $(this).val(picker.startDate.format("DD MMMM YYYY"));
        });

        $('.date').on('cancel.daterangepicker', function (ev, picker) {
            $(this).val('');
        });
        $('.daterange').on('apply.daterangepicker', function (ev, picker) {
            $(this).val(picker.startDate.format("DD MMMM YYYY") + ' - ' + picker.endDate.format("DD MMMM YYYY"));
        });

        $('.daterange').on('cancel.daterangepicker', function (ev, picker) {
            $(this).val('');
        });
    });

    function getParameterByName(name, url = window.location.href) {
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }
</script>
