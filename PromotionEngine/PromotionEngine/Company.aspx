<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs"
    Inherits="PromotionEngine.Company" Title="Promotion Engine - Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .k-upload-selected
        {
            display: none;
        }
    </style>
    <script type="text/javascript">
        var oCompany = {};
        var isInsert = false;
        var companyData;
        var gird;
        var fileUpload;
        function showDetails(e) {
            wnd.center().open();
        }
        function closeImport() {
            resetUpload();
            wnd.close();
        }
        function ImportProcess(e) {
            $('.k-upload-selected').trigger('click');
            resetUpload();
            wnd.close();
        }
        function getFileInfo(e) {
            return $.map(e.files, function (file) {
                var info = file.name;

                // File size is not available in all browsers
                if (file.size > 0) {
                    info += " (" + Math.ceil(file.size / 1024) + " KB)";
                }
                return info;
            }).join(", ");
        }
        function onUpload(e) {
        }

        function onSuccess(e) {
           
        }
        $(document).ready(function () {
            $("#btnImport").kendoButton({
                spriteCssClass: "k-icon k-update"
            });
            fileUpload = $("#files").kendoUpload({
                multiple: false,
                showFileList: true,
                async: {
                    saveUrl: "save",
                    removeUrl: "remove",
                    autoUpload: false
                },
                localization: {
                    select: 'Select csv file'

                },
                //template: kendo.template($('#fileTemplate').html()),
                select: onSelectUploadDataFile,
                success: onSuccess,
                upload: onUpload
            });
            //Import Template
            //$("#importPopup").load("popup_import_data.htm");
            //Import Popup
            wnd = $("#importPopup")
                        .kendoWindow({
                            title: "Import Company",
                            modal: true,
                            visible: false,
                            resizable: false,
                            height: 230,
                            width: 406
                        }).data("kendoWindow");

            //Load Grid
            grid = $("#grid").kendoGrid({
                dataSource: {
                    transport: {
                        read: {
                            type: "GET",
                            url: "Company.aspx/GetCompanys",
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
    <script id="fileTemplate" type="text/x-kendo-template">
    <div>
        <p>Name: #=name#</p>
        <p>Size: #=size# bytes</p>
       <p>Extension: #=files[0].extension#</p>
    </div>
    </script>
    <div id="importPopup" style="padding: 0;">
        <table style="width: 100%; height: 100%;" border="0px">
            <tr>
                <td style="height: 40%;">
                    <input name="files" id="files" type="file" runat="server" clientidmode="Static" />
                </td>
            </tr>
            <tr>
                <td>
                    <div class="k-edit-form-container" style="position: relative;">
                        <div class="k-edit-buttons k-state-default">
                            <button type="button" id="btnImport" onclick="ImportProcess();" class="k-button k-button-icontext k-primary">
                                Import File</button><a class="k-button k-button-icontext k-grid-cancel" href="#"
                                    id="btnClose" onclick="closeImport();"><span class="k-icon k-cancel"></span>Cancel</a></div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
