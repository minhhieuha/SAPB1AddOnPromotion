<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Company.aspx.cs" Inherits="PromotionEngine.Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var oCompany = {};
        $(document).ready(function () {



            $("#btnSave").click(function () {
                var num = 1;
                oCompany.CompanyCode = $("#txtcompany-code").val();
                oCompany.CompanyName = $("#txtcompany-name").val();
                if ($("#chkIsActive").is(':checked')) {
                    oCompany.IsActive = 'true';
                }
                else {
                    oCompany.IsActive = 'false';
                }
                oCompany.Address = $("#txtcompany-address").val();
                oCompany.ContactPerson = $("#txtcompany-person").val();
                oCompany.ContactPhone = $("#txtcompany-phone").val();
                $.ajax({
                    type: "POST",
                    url: "Company.aspx/UpdateCompany",
                    data: JSON.stringify({
                        oCompany: JSON.stringify(oCompany)
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        //bindGrid(data.d);
                        $("#myModal").modal('hide'); //hide popup  
                        window.parent.location.reload();
                    },
                    error: function (xhr, status, err) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.Message);

                    }
                });
            });
        });
        function initCompany() {

            oCompany.CompanyCode = '';
            oCompany.CompanyName = '';
            oCompany.IsActive = '';
            oCompany.Address = '';
            oCompany.ContactPerson = "";
            oCompany.ContactPhone = "";

        }
    </script>
    <asp:GridView ID="grvCompany" runat="server" CssClass="table table-striped table-bordered table-condensed"
        Width="100%" AllowPaging="false">
        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
    </asp:GridView>
    <asp:Button ID="btnAddNew" runat="server" data-toggle="modal" Text="Add New" CssClass="btn btn-primary btn-lg"
        data-target="#myModal" OnClick="btnAddNew_Click" />
    <!-- Button trigger modal -->
    <%--<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
  Launch demo modal
</button>--%>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">
                        Company</h4>
                </div>
                <div class="modal-body">
                    <table style="width: 100%; border: 2px;">
                        <tr>
                            <td style="width: 120px;">
                                <label for="recipient-name" class="control-label">
                                    Company Code:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtcompany-code" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Company Name:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtcompany-name" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Company Address:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtcompany-address" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Company Person:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtcompany-person" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Company Phone:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtcompany-phone" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="form-control">
                                IsActive:
                            </td>
                            <td>
                                <input type="checkbox" class="form-control" id="chkIsActive"></label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close</button>
                    <button type="button" id="btnSave" class="btn btn-primary">
                        Save changes</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
