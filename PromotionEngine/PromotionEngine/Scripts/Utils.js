function generatePassword() {
    var length = 8,
        charset = "abcdefghijklnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
        retVal = "";
    for (var i = 0, n = charset.length; i < length; ++i) {
        retVal += charset.charAt(Math.floor(Math.random() * n));
    }
    return retVal;
}
function resetUpload() {
    $(".k-upload-files").remove();
    $(".k-upload-status").remove();
    $(".k-upload.k-header").addClass("k-upload-empty");
    $(".k-upload-button").removeClass("k-state-focused");
    $(".k-upload-files.k-reset").find("li").remove();
}
var onSelectUploadDataFile = function (event) {
    $.each(event.files, function (index, value) {
        if (value.extension !== '.csv') {
            event.preventDefault();
            alert("Please upload csv files");
        }
        console.log("Name: " + value.name);
        console.log("Size: " + value.size + " bytes");
        console.log("Extension: " + value.extension);
    });
};