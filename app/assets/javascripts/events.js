$(document).ready(function() {

  $("img.issue-mark").click(function(e){
  	e.preventDefault();
  	debugger;
  	var form = $(this).parent().parent().find("form.event_issue");
	if (form.css("display")=="none"){
		form.css("display", "block");
	} else {
		form.css("display", "none");
	}
  });

  $("form.event_issue").submit(function(e){
	e.preventDefault();
	debugger;
	var form = $(this);
	var list = form.parent().parent().find("div.issue_body");
	$.ajax({
	    url: form.attr("action"),
	    method: form.attr("method"),
	    data: form.serialize(),
	    success: function(response){
	    	debugger;
	        list.append(response);
        	form[0].reset();
        	form.css("display","none");
      	}
    });
  });

  $(".new_event").on("ajax:success", function(e, data, status, xhr) {
  $("#event_list").append(xhr.responseText);
  $(".event_fields").val("")
  return console.log("stuff", xhr.responseText);
}).on("ajax:error", function(e, xhr, status, error) {
  console.log("Failure!!")
  return $("#new_event").prepend("<p>ERROR</p>");
});
});