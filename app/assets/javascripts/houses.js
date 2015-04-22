$(document).ready(function() {


  $("#edit-house-link").on("click", function(event) {
    event.preventDefault();
    console.log(">>>>>>>>>>>>>>>>>>>>");
    $("#edit-house-form-div").css("display", "block")
  })

  $("#edit-house-manager-link").on("click", function(event) {
    event.preventDefault();
    console.log(">>>>>>>>>>>>>>>>>>>>");
    $("#edit-house-manager-form-div").css("display", "block")
  })
});