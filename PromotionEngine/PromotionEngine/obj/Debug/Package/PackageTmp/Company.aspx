<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs"
    Inherits="PromotionEngine.Company" Title="Promotion Engine - Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var oCompany = {};
        var isInsert = false;
        var companyData;
        var gird;
        function showDetails(e) {
            wnd.center().open();
        }
        function closeImport() {
            wnd.close();
        }
        function ImportProcess() {
            wnd.close();
        }
        $(document).ready(function () {
            //Import Template
            $("#importPopup").load("popup_import_data.htm");
            //Import Popup
            wnd = $("#importPopup")
                        .kendoWindow({
                            title: "Import Company",
                            modal: true,
                            visible: false,
                            resizable: false,
                            height: 150,
                            width: 406
                        }).data("kendoWindow");

            //Load Grid
            grid = $("#grid").kendoGrid({
                dataSource: {
                    transport: {
                        read: {
                            type: "GET",
                            url: "Company.aspx/GetCompanys1",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json"
                        },
                        serverPaging: true,
                        serverSorting: true,
                        serverFiltering: true
                    },
                    type: "odata", //Important!!!!
                    schema: {
                            data: "d.Data",
                            total: "d.Count",
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
                pageable: {
                    pageSize: 20,
                    refresh: true
                },
                filterable: true,
                reorderable: true,
                resizable: true,
                height: 450,
                toolbar: [{ name: 'create', text: 'Add New Company' }, { name: 'excel' },
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
                            { command: ["edit"], title: "Action", width: "170px" }
                            ],
                editable: {
                    mode: "popup",
                    confirmation: "Are you sure you want to remove this company?"
                },
                edit: function (e) {
                    var editWindow = e.container.data("kendoWindow");
                    if (e.model.isNew()) {
                        e.container.data("kendoWindow").title('Add New Company');
                        $("a.k-grid-update")[0].innerHTML = "<span class='k-icon k-update'></span>Save";
                        isInsert = true;
                    }
                    else {
                        e.container.data("kendoWindow").title('Edit Company');
                        $('[name="CompanyCode"]').attr("readonly", true);
                        isInsert = false;
                    }
                },
                save: function (e) {
                    var listTextBox = $("input:text");
                    for (var i = 0; i < listTextBox.length; i++) {
                        var name = listTextBox[i].name;
                        if (name.length > 0) {
                            oCompany[name] = $("[name=" + name + "]").val();
                        }

                    }
                    var listCheckBox = $("input:checkbox");
                    for (var i = 0; i < listCheckBox.length; i++) {
                        var name = listCheckBox[i].name;
                        if (name.length > 0) {
                            if ($("[name=" + name + "]").is(':checked')) {
                                oCompany.IsActive = 'true';
                            }
                            else {
                                oCompany.IsActive = 'false';
                            }
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
                                grid.dataSource.read();
                            }
                        },
                        error: function (xhr, status, err) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.Message);
                        }
                    });
                    this.refresh();
                }
            }).data("kendoGrid");
        });
    </script>
    <script id="grid_toolbar" type="text/x-kendo-template">
   <a href="\#" class="k-button k-button-icontext" id="grid_toolbar_queryBtn"       
            onclick="return showDetails();"><span class="k-icon k-i-excel"></span>Import</a>
    </script>
    <div id="grid">
    </div>
    <div id="importPopup" style="padding: 0;">
    </div>
</asp:Content>
