<%@ Page Language="C#" validateRequest="false" AutoEventWireup="true" CodeBehind="ParamApprv.aspx.cs" Inherits="MikroMnt.Parameter.ParamApprv" %>
 

<%@ Register src="USC_paraminput.ascx" tagname="USC_paraminput" tagprefix="uc1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../include/style.css" type="text/css" rel="Stylesheet" />
    <!-- #include file="~/include/onepost.html" -->
    <!-- #include file="~/include/uc/UC_Currency.html" -->
    <!-- #include file="~/include/uc/UC_Number.html" -->
    <script type="text/javascript" language="javascript">
    
        function all()
        {            
            var keyAPPRV = new Array(); 
            keyAPPRV = document.form1.hAPPRV.value.split(","); 
            for(x=0;x<keyAPPRV.length;x++)
            {
                rbAPPRV = document.getElementById("rbAPPRV"+keyAPPRV[x]);
                if(rbAPPRV!=null)
                   rbAPPRV.checked = true; 
            }
            var keyREJCT = new Array(); 
            keyREJCT = document.form1.hREJCT.value.split(",");
            for(y=0;y<keyREJCT.length;y++)
            {
                rbREJCT = document.getElementById("rbREJCT"+keyREJCT[y]);
                if(rbREJCT!=null)
                    rbREJCT.checked = true; 
            }
            var keyCANCL = new Array(); 
            keyCANCL = document.form1.hCANCL.value.split(",");
            for(z=0;z<keyCANCL.length;z++)
            {
                rbCANCL = document.getElementById("rbCANCL"+keyCANCL[z]);
                if(rbCANCL!=null)
                    rbCANCL.checked = true; 
            }
        }
    
        function allAPPRV()
        {
            document.form1.hAPPRV.value = document.form1.hALL.value;
            document.form1.hCANCL.value = "";
            document.form1.hREJCT.value = "";
            all();
        }

        function allREJCT()
        {
            document.form1.hAPPRV.value = "";
            document.form1.hREJCT.value = document.form1.hALL.value;
            document.form1.hCANCL.value = "";
            all();
        }


        function allCANCL()
        {
            document.form1.hAPPRV.value = "";
            document.form1.hREJCT.value = "";
            document.form1.hCANCL.value = document.form1.hALL.value;
            all();            
        }
        
        function APPRV(key)
        {
            if(document.form1.hAPPRV.value.indexOf(key+",")<0)
                document.form1.hAPPRV.value += key+",";
            document.form1.hREJCT.value = document.form1.hREJCT.value.replace(key+",", "");
            document.form1.hCANCL.value = document.form1.hCANCL.value.replace(key+",", "");
        }
        
        function REJCT(key)
        {
            if(document.form1.hREJCT.value.indexOf(key+",")<0)
                document.form1.hREJCT.value += key+",";
            document.form1.hAPPRV.value = document.form1.hAPPRV.value.replace(key+",", "");
            document.form1.hCANCL.value = document.form1.hCANCL.value.replace(key+",", "");
        }
        
        function CANCL(key)
        {
            if(document.form1.hCANCL.value.indexOf(key+",")<0)
                document.form1.hCANCL.value += key+",";
            document.form1.hAPPRV.value = document.form1.hAPPRV.value.replace(key+",", "");
            document.form1.hREJCT.value = document.form1.hREJCT.value.replace(key+",", "");
        }

    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
   <%-- <table width="100%">
        <tr>
            <td class="H0" align="right">
                <a href="<% =BackURL %>"><img src="../image/back.jpg" alt="back" /></a>
                <a href="../Body.aspx"><img src="../image/MainMenu.JPG" alt="mainmenu" /></a>
                <a href="../Logout.aspx" target="_top"><img src="../image/logout.jpg" alt="logout" /></a>
            </td>
        </tr>
    </table>--%>
    <table class="Box1" width="100%">
    <tr class ="H1"><td>
        <asp:Label ID="title" runat="server" Text="Label"></asp:Label>
    </td></tr>
    <tr><td>
        <input type="hidden" id="hALL" runat="server" />
        <input type="hidden" id="hAPPRV" runat="server" />
        <input type="hidden" id="hCANCL" runat="server" />
        <input type="hidden" id="hREJCT" runat="server" />
        
        <dx:ASPxGridView ID="gridpending" ClientInstanceName="gridpending" 
            runat="server" AutoGenerateColumns="False" Width="100%" Font-Size="10px"
            OnLoad="gridpending_Load"
            OnBeforeColumnSortingGrouping="gridpending_BeforeColumnSortingGrouping" >
            <SettingsPager PageSize="20" />
            <Settings ShowFilterRow="True" ShowGroupedColumns="True" ShowGroupPanel="True" />
            <ClientSideEvents  EndCallback="function(s, e) {
	        all();
}" />
             <Columns>
             <dx:GridViewCommandColumn VisibleIndex="0" Width="1px" ShowClearFilterButton="true"> 
                 <HeaderTemplate>
                    <table>
                        <tr class="<%=funcpendCss %>" >
                          <td>
                            <input class="Bt1" type="button" onclick="gridpending.ExpandAll();"   value=" Expand All " /> 
                          </td>
                        </tr>
                        <tr class="<%=funcpendCss %>">
                          <td>
                            <input class="Bt1" type="button" onclick="gridpending.CollapseAll();" value="Collapse All" />   
                          </td>
                        </tr>
                    </table>                                        
                 </HeaderTemplate>
             </dx:GridViewCommandColumn>
             <dx:GridViewDataColumn VisibleIndex="1" Width="1%" >
                 <CellStyle Wrap="False">
                 </CellStyle>
                 <HeaderTemplate>
                    <table width="100%">
                        <tr>
                          <td align="center">
                                Approve
                          </td>
                        </tr>
                        <tr align="center">
                          <td>
                             <a href="javascript:allAPPRV()">All</a>
                          </td>
                        </tr>
                    </table>                                        
                 </HeaderTemplate>
                <DataItemTemplate>
                    <table width="100%">
                        <tr>
                          <td align="center">
                             <input type="radio" id="<%# "rbAPPRV"+Container.KeyValue.ToString() %>" name="<%# "rb"+Container.KeyValue.ToString() %>" onclick="<%# "APPRV('"+Container.KeyValue.ToString() +"')" %>" />
                          </td>
                        </tr>
                    </table>      
                </DataItemTemplate>
             </dx:GridViewDataColumn>
             <dx:GridViewDataColumn VisibleIndex="2" Width="1%" >
                 <CellStyle Wrap="False">
                 </CellStyle>
                 <HeaderTemplate>
                    <table width="100%">
                        <tr>
                          <td align="center">
                                Reject
                          </td>
                        </tr>
                        <tr align="center">
                          <td>
                             <a href="javascript:allREJCT()">All</a>
                          </td>
                        </tr>
                    </table>                                        
                 </HeaderTemplate>
                <DataItemTemplate>
                    <table width="100%">
                        <tr>
                          <td align="center">
                             <input type="radio" id="<%# "rbREJCT"+Container.KeyValue.ToString() %>" name="<%# "rb"+Container.KeyValue.ToString() %>"  onclick="<%# "REJCT('"+Container.KeyValue.ToString() +"')" %>"/>
                          </td>
                        </tr>
                    </table>      
                </DataItemTemplate>
             </dx:GridViewDataColumn>
             <dx:GridViewDataColumn VisibleIndex="3" Width="1%" >
                 <CellStyle Wrap="False">
                 </CellStyle>
                 <HeaderTemplate>
                    <table width="100%">
                        <tr>
                          <td align="center">
                                Cancel
                          </td>
                        </tr>
                        <tr align="center">
                          <td>
                             <a href="javascript:allCANCL()">All</a>
                          </td>
                        </tr>
                    </table>                                        
                 </HeaderTemplate>
                <DataItemTemplate>
                    <table width="100%">
                        <tr>
                          <td align="center">
                             <input type="radio" id="<%# "rbCANCL"+Container.KeyValue.ToString() %>" name="<%# "rb"+Container.KeyValue.ToString() %>" onclick="<%# "CANCL('"+Container.KeyValue.ToString() +"')" %>" />
                          </td>
                        </tr>
                    </table>      
                </DataItemTemplate>
             </dx:GridViewDataColumn>
             </Columns>
             </dx:ASPxGridView>
        </td>
    </tr>
    <tr class="F1">
        <td>
            <asp:Button class="Bt1"  ID="btnSubmit" runat="server" Text="Submit" 
                onclick="btnSubmit_Click" />
        </td>
        
    </tr>
    </table>  
    </div>
    </form>
</body>
</html>
