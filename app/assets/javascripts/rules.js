$(document).ready(function() {

  $(".new_rule").on("ajax:success", function(e, data, status, xhr) {
  console.log("&&&&&&&&&&&&&&&&&&&&&&&")
  $("#rule_list").append(xhr.responseText);
  $(".rule_fields").val("")
  return console.log("stuff", xhr.responseText);
}).on("ajax:error", function(e, xhr, status, error) {
  console.log("Failure!!")
  return $("#new_rule").prepend("<p>ERROR</p>");
});
});