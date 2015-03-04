<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="User.aspx.cs" Inherits="PromotionEngine.User" Title="Promotion Engine - User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var oUser = {};
        var isInsert = false;
        var jsonCompany = {}
        $(document).ready(function () {
            GetCompanys();
            GetUsers();
        });
        function showPassword(checkboxElem) {
            if (checkboxElem.checked) {
                $('#Password').attr('type', 'text');
            } else {
                $('#Password').attr('type', 'password');
            }
        }
        function initUser() {

            oUser.UserID = 0;
            oUser.CompanyCode = '';
            oUser.UserName = '';
            oUser.Password = ''
            oUser.Email = '';
            oUser.Phone = '';
            oUser.IsActive = false;
            oUser.IsTrial = false;
            oUser.IsAdmin = false;
        }
        //Get All User
        function GetUsers() {
            $.ajax({
                type: "POST",
                url: "User.aspx/GetUsers",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }
        //Get All User
        function GetCompanys() {
            $.ajax({
                type: "POST",
                url: "User.aspx/GetCompanys",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    jsonCompany = $.parseJSON(data.d)
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }
    </script>
    <script type="text/javascript">
        function passwordEditor(container, options) {
            $('<input type="password" class="k-input k-textbox" required data-bind="value:' + options.field + '"/>').appendTo(container);
        };
        function UpdateData() {
            $.ajax({
                type: "POST",
                url: "User.aspx/UpdateUser",
                data: JSON.stringify({
                    oUser: JSON.stringify(oUser),
                    isInsert: isInsert
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    
                    //Reload Data 
                    //GetUsers();
//                    var resultData = {};
//                    $.ajax({
//                        type: "POST",
//                        url: "User.aspx/GetUsers",
//                        data: '',
//                        contentType: "application/json; charset=utf-8",
//                        dataType: "json",
//                        success: function (data) {
//                            alert(data.d);
//                            resultData = $.parseJSON(data.d)
//                            var dataSource = new kendo.data.DataSource({ data: resultData });

//                            var grid = $('#grid').data("kendoGrid");
//                            dataSource.read();
//                            grid.setDataSource(dataSource)


//                           
//                        },
//                        failure: function (response) {
//                            alert(response.d);
//                        },
//                        error: function (response) {
//                            alert(response.d);
//                        }
//                    });
                    
                },
                error: function (xhr, status, err) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.Message);
                }
            });
        }
        function onRequestEnd(e) {


            //Check request type
            if (e.type == "create" || e.type == "update") {
                //check for errors in the response
                if (e.response == null || e.response.Errors == null) {
                    $('#grid').data().kendoGrid.dataSource.read();
                    alert("Update Successful");
                }
                else {
                    alert("Update Failed");
                }
            }
        }
        //Bind Data
        function OnSuccess(response) {
            var data = $.parseJSON(response.d);
            var grid = $("#grid").kendoGrid({
                dataSource: { data: data,
                    pageSize: 20,
                    schema: {
                        type: 'json',
                        model: {
                            id: "UserID",
                            fields: {
                                UserName: { type: "string", validation: { required: true} },
                                CompanyCode: { type: "string", validation: { required: true} },
                                Password: { type: "string", validation: { required: true} },
                                IsAdmin: { type: "boolean" },
                                IsTrial: { type: "boolean" },
                                IsActive: { type: "boolean" },
                                Email: { type: "string", validation: { required: true} },
                                Phone: { type: "string", validation: { required: true} }
                                //                                Company: { defaultValue: { CompanyCode: 0, CompanyName: "[Select Company]"} }
                            }
                        }
                    }
                },
                filterable: true,
                height: 500,
                sortable: true,
                toolbar: [{ name: 'create', text: 'Add New User' }, { name: 'excel'}],
                excel: {
                    fileName: "User List.xlsx",
                    filterable: true
                },
                pageable: true,
                batch: true,
                columns: [{ field: "UserID", title: "UserID", width: 70, hidden: true },
                            { field: "UserName", title: "User Name", width: 100 },
                            { field: "CompanyName", title: "Company", width: 200 },
                            { field: "CompanyCode", title: "Company", width: 200, hidden: true },
                            { field: "Password", title: "Password", width: 100, hidden: true },
                            { field: "Email", title: "Email", width: 300 },
                            { field: "Phone", title: "Phone" },
                            { field: "IsAdmin", title: "Admin" },
                            { field: "IsTrial", title: "Trial" },
                            { field: "IsActive", title: "Active", width: 70 },
                            { command: ["edit"], title: "Action", width: "100px"}]
                , editable: {
                    mode: "popup",
                    template: $("#template").html(),
                    confirmation: "Are you sure you want to remove this user?"
                },
                edit: function (e) {
                    $('#ddlCompany').kendoDropDownList({
                        optionLabel: "[Select Company]",
                        dataTextField: "CompanyName",
                        dataValueField: "CompanyCode",
                        dataSource: {
                            data: jsonCompany
                        }
                    });

                    var editWindow = e.container.data("kendoWindow");
                    $('[name="UserID"]').attr("disabled", true);
                    $('[name="CompanyName"]').attr("display", false);
                    if (e.model.isNew()) {
                        $('[name="Password"]').val(generatePassword());
                        e.container.data("kendoWindow").title('Add New User');
                        $("a.k-grid-update")[0].innerHTML = "<span class='k-icon k-update'></span>Save";
                        isInsert = true;
                        $('[name="UserName"]').attr("readonly", false);
                        initUser();
                    }
                    else {
                        e.container.data("kendoWindow").title('Edit User');
                        $('[name="UserName"]').attr("readonly", true);

                        isInsert = false;
                    }
                },
                remove: function (e) {
                    //alert("delete event captured");
                },
                onRequestEnd: onRequestEnd,
                save: function (e) {
                    var that = this;
                    var num = 1;
                    var listTextBox = $("input:text");
                    for (var i = 0; i < listTextBox.length; i++) {
                        var name = listTextBox[i].name;
                        if (name.length > 0) {
                            oUser[name] = $("[name=" + name + "]").val();
                        }
                    }
                    var listPassword = $("input:password");
                    for (var i = 0; i < listPassword.length; i++) {
                        var name = listPassword[i].name;
                        if (name.length > 0) {
                            if (name.length > 0) {
                                oUser[name] = $("[name=" + name + "]").val();
                            }
                        }
                    }

                    var listCheckBox = $("input:checkbox");
                    for (var i = 0; i < listCheckBox.length; i++) {
                        var name = listCheckBox[i].name;
                        if (name.length > 0) {
                            if ($("[name=" + name + "]").is(':checked')) {
                                oUser[name] = 'true';
                            }
                            else {
                                oUser[name] = 'false';
                            }
                        }
                    }
                    oUser.Email = $("[name=Email]").val();
                    oUser.CompanyCode = $("#ddlCompany").val();

                    //Update or Insert User
                    UpdateData();
                    if (isInsert) {
                        location.reload();
                    }
                }
            });
        };
    </script>
    <script type="text/x-kendo-template" id="template">    
          <div class="k-edit-form-container"  >
        <div class="k-edit-label" style="display:none;">
            <label for="UserID">
                UserID</label>
        </div>
        <div class="k-edit-field" data-container-for="UserID"  style="display:none;">
            <input name="UserID" disabled="disabled" class="k-input k-textbox" type="text" data-bind="value:UserID"></div>
        <div class="k-edit-label">
            <label for="UserName">
                User Name</label></div>
        <div class="k-edit-field" data-container-for="UserName">
            <input name="UserName" class="k-input k-textbox" required="required" type="text"
                readonly="readonly" data-bind="value:UserName">
        </div>
        <div class="k-edit-label">
            <label for="CompanyCode">
                Company</label></div>
        <div data-container-for="CompanyCode" class="k-edit-field">
             <input id="ddlCompany" name="CompanyCode" data-bind="value:CompanyCode" required="required" validationMessage = "Company is required")>
            </div>
        <div class="k-edit-label">
            <label for="Password">
                Password</label></div>
        <div class="k-edit-field" data-container-for="Password">
            <input class="k-input k-textbox" required="required" type="password" data-bind="value:Password" name="Password" id="Password">
        </div>
        <div class="k-edit-label">
            <label for="ShowPassword">
                Show Password</label>
        </div>
        <div class="k-edit-field" >
            <input  id="ShowPassword" type="checkbox" onClick="showPassword(this);">
        </div>
        <div class="k-edit-label">
            <label for="Email">
                Email</label>
        </div>
        <div class="k-edit-field" data-container-for="Email">
            <input name="Email" class="k-input k-textbox" required="required" type="email" data-bind="value:Email">
        </div>
        <div class="k-edit-label">
            <label for="Phone">
                Phone</label></div>
        <div class="k-edit-field" data-container-for="Phone">
            <input name="Phone" class="k-input k-textbox" required="required" type="text" data-bind="value:Phone"></div>
        <div class="k-edit-label">
            <label for="IsAdmin">
                Admin</label>
        </div>
        <div class="k-edit-field" data-container-for="IsAdmin">
            <input name="IsAdmin" type="checkbox" data-bind="checked:IsAdmin" data-type="boolean">
        </div>
        <div class="k-edit-label">
            <label for="IsTrial">
                Trial</label></div>
        <div class="k-edit-field" data-container-for="IsTrial">
            <input name="IsTrial" type="checkbox" data-bind="checked:IsTrial" data-type="boolean"></div>
        <div class="k-edit-label">
            <label for="IsActive">
                Active</label></div>
        <div class="k-edit-field" data-container-for="IsActive">
            <input name="IsActive" type="checkbox" data-bind="checked:IsActive" data-type="boolean"></div>
    </div>
          
    </script>
    <div style="position: absolute; z-index: 0;">
    <div id="grid">
    </div>
    </div>
</asp:Content>
