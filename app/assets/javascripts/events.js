$(document).ready(function() {

  $(".new_event").on("ajax:success", function(e, data, status, xhr) {
  console.log("&&&&&&&&&&&&&&&&&&&&&&&")
  $("#event_list").append(xhr.responseText);
  $(".event_fields").val("")
  return console.log("stuff", xhr.responseText);
}).on("ajax:error", function(e, xhr, status, error) {
  console.log("Failure!!")
  return $("#new_event").prepend("<p>ERROR</p>");
});
});