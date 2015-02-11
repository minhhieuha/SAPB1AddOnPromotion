<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="User.aspx.cs" Inherits="PromotionEngine.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
      var oUser = {};
      $(document).ready(function () {

          $.ajax({
              type: "POST",
              url: "User.aspx/GetAllCompany",
              data: "",
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (Result) {
                  $.each(Result.d, function () {
                      $("#dllCompany").append($("<option></option>").val(this['Text']).html(this['Value']));
                  });

              },
              error: function (xhr, status, err) {
                  var err = eval("(" + xhr.responseText + ")");
                  alert(err.Message);

              }
          });

          $("#btnSave").click(function () {

              var num = 1;
              oUser.CompanyCode = $("#dllCompany").val();
              oUser.UserName = $("#txtUser-username").val();
              if ($("#chkIsActive").is(':checked')) {
                  oUser.IsActive = 'true';
              }
              else {
                  oUser.IsActive = 'false';
              }
              if ($("#chkIsAdmin").is(':checked')) {
                  oUser.IsAdmin = 'true';
              }
              else {
                  oUser.IsAdmin = 'false';
              }
              if ($("#chkIsTrial").is(':checked')) {
                  oUser.IsTrial = 'true';
              }
              else {
                  oUser.IsTrial = 'false';
              }
              oUser.Email = $("#txtUser-email").val();
              oUser.Phone = $("#txtUser-phone").val();
              $('input[type=password]').each(function (index, value) {
                  //oUser.Password = value.value;
              });
              oUser.Password = $("#txtUser-password").val();
              $.ajax({
                  type: "POST",
                  url: "User.aspx/UpdateUser",
                  data: JSON.stringify({
                      oUser: JSON.stringify(oUser)
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
    <asp:GridView ID="grvUser" runat="server" CssClass="table table-striped table-bordered table-condensed"
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
                        User</h4>
                </div>
                <div class="modal-body">
                    <table style="width: 100%; border: 2px;">
                        <tr>
                            <td style="width: 120px;">
                                <label for="recipient-name" class="control-label">
                                    Company :</label>
                            </td>
                            <td>
                                <select class="selectpicker" id="dllCompany">
                                </select>
                                <asp:DropDownList ID="drpCompany" runat="server" CssClass="selectpicker" Visible="false">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    User Name:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtUser-username" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Password:</label>
                            </td>
                            <td>
                                <input type="password" class="form-control" id="txtUser-password" style="width: 350px;">
                            </td>
                        </tr>
                          <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Confirm Password:</label>
                            </td>
                            <td>
                                <input type="password" class="form-control" id="txtUser-confirm-password" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Email:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtUser-email" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="control-label">
                                    Phone:</label>
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txtUser-phone" style="width: 350px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="form-control">
                                IsActive:</label>
                            </td>
                            <td>
                                <input type="checkbox" class="form-control" id="chkIsActive">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="form-control">
                                IsAdmin:</label>
                            </td>
                            <td>
                                <input type="checkbox" class="form-control" id="chkIsAdmin">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="recipient-name" class="form-control">
                                IsTrial:</label>
                            </td>
                            <td>
                                <input type="checkbox" class="form-control" id="chkIsTrial">
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
