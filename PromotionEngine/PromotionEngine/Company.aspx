<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs"
    Inherits="PromotionEngine.Company" Title="Promotion Engine - Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var oCompany = {};
        var isInsert = false;
        $(document).ready(function () {
            $("#files").kendoUpload();
            GetCompanys();

        });
        function importData() {
            alert("aa");
            return true;
        }
        function initCompany() {

            oCompany.CompanyCode = '';
            oCompany.CompanyName = '';
            oCompany.IsActive = false;
            oCompany.Address = '';
            oCompany.ContactPerson = "";
            oCompany.ContactPhone = "";

        }
        //Get All Company
        function GetCompanys() {
            $.ajax({
                type: "GET",
                url: "Company.aspx/GetCompanys",
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
        function addExtensionClass(extension) {
            switch (extension) {
                case '.jpg':
                case '.img':
                case '.png':
                case '.gif':
                    return "img-file";
                case '.doc':
                case '.docx':
                    return "doc-file";
                case '.xls':
                case '.xlsx':
                    return "xls-file";
                case '.pdf':
                    return "pdf-file";
                case '.zip':
                case '.rar':
                    return "zip-file";
                default:
                    return "default-file";
            }
        }
    </script>
    <script type="text/javascript">
        //Bind Data
        function OnSuccess(response) {
            var data = $.parseJSON(response.d);
            var grid = $("#grid").kendoGrid({
                dataSource: { data: data,
                    pageSize: 20,
                    schema: {
                        type: 'json',
                        model: {
                            id: "CompanyCode",
                            fields: {
                                CompanyCode: { type: "string", validation: { required: true} },
                                CompanyName: { type: "string", validation: { required: true} },
                                Address: { type: "string", validation: { required: true} },
                                ContactPerson: { type: "string", validation: { required: true} },
                                ContactPhone: { type: "string", validation: { required: true} },
                                IsActive: { type: "boolean" }
                            }
                        }
                    }
                },
                sortable: true,
                pageable: true,
                groupable: true,
                filterable: true,
                columnMenu: true,
                reorderable: true,
                resizable: true,
                height: 500,
                toolbar: [{ name: 'create', text: 'Add New Company' }, { name: 'excel'},
                 { text: '', template: kendo.template($("#grid_toolbar").html())}],
                excel: {
                    fileName: "Company List.xlsx",
                    filterable: true
                },
                batch: true,
                columns: [{ field: "CompanyCode", title: "Code", width: 100 },
                            { field: "CompanyName", title: "Name", width: 300 },
                            { field: "Address", title: "Address", width: 300 },
                            { field: "ContactPerson", title: "Contact Person" },
                            { field: "ContactPhone", title: "Contact Phone" },
                            { field: "IsActive", title: "Active", width: 100 },
                            { command: ["edit"], title: "Action", width: "170px"}]
                , editable: {
                    mode: "popup",
                    confirmation: "Are you sure you want to remove this company?"
                },
                edit: function (e) {
                    var editWindow = e.container.data("kendoWindow");

                    if (e.model.isNew()) {
                        e.container.data("kendoWindow").title('Add New Company');
                        $("a.k-grid-update")[0].innerHTML = "<span class='k-icon k-update'></span>Save";
                        isInsert = true;
                        initCompany();
                    }
                    else {
                        e.container.data("kendoWindow").title('Edit Company');
                        $('[name="CompanyCode"]').attr("readonly", true);
                        isInsert = false;
                    }
                },
                remove: function (e) {
                    //alert("delete event captured");
                    //Do your logic here before delete the record.
                },
                save: function (e) {
                    var that = this;
                    var num = 1;
                    var listTextBox = $("input:text");
                    for (var i = 0; i < listTextBox.length; i++) {
                        var name = listTextBox[i].name;
                        oCompany[name] = $("[name=" + name + "]").val();

                    }
                    var listCheckBox = $("input:checkbox");
                    for (var i = 0; i < listCheckBox.length; i++) {
                        var name = listCheckBox[i].name;
                        if ($("[name=" + name + "]").is(':checked')) {
                            oCompany.IsActive = 'true';
                        }
                        else {
                            oCompany.IsActive = 'false';
                        }
                    }
                    //Update or Insert Company
                    $.ajax({
                        type: "POST",
                        url: "Company.aspx/UpdateCompany",
                        data: JSON.stringify({
                            oCompany: JSON.stringify(oCompany),
                            isInsert: isInsert
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            //Reload Data 
                            if (isInsert) {
                                GetCompanys();
                            }
                        },
                        error: function (xhr, status, err) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.Message);
                        }
                    });
                }
            });
        };
    </script>
    <script id="grid_toolbar" type="text/x-kendo-template">  
    <span class="k-button k-button-icontext k-grid-excel" id="grid_toolbar_queryBtn"
                onclick="return importData(); return true;"><span class="k-icon k-i-excel"></span>Import</span>
    </script>
    <div style="position: absolute; z-index: 0; direction: ltr; margin-right: 8px; margin-bottom: 5px;">
        <div class="demo-section k-header" style="border-color: #ccc; border-radius: 4px;
            border-width: 1px; border-style: solid;">
            <input name="files" id="files" type="file" data-role="upload" autocomplete="off" text="Select import files....">
        </div>
        </br>
        <div id="grid">
        </div>
    </div>
</asp:Content>
