$(document).ready(function() {

  $(".new_chore").on("ajax:success", function(e, data, status, xhr) {
  console.log("&&&&&&&&&&&&&&&&&&&&&&&")
  $("#chore_list").append(xhr.responseText);
  $(".chore_fields").val("")
  return console.log("stuff", xhr.responseText);
}).on("ajax:error", function(e, xhr, status, error) {
  console.log("Failure!!")
  return $("#new_event").prepend("<p>ERROR</p>");
});
});