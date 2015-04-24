$(document).ready(function() {

  $("img.issue-mark").click(function(e){
  	e.preventDefault();
  	var form = $(this).parent().parent().find("form.rule_issue");
	if (form.css("display")=="none"){
		form.css("display", "block");
	} else {
		form.css("display", "none");
	}
  });

  $("form.rule_issue").submit(function(e){
	e.preventDefault();
	var form = $(this);
	var list = form.parent().parent().find("td.rule-content");
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

  $(".new_rule").on("ajax:success", function(e, data, status, xhr) {
  $("#rule_list").append(xhr.responseText);
  $(".rule_fields").val("")
  $(".rule-length").css("display", "none")
  return console.log("stuff", xhr.responseText);
}).on("ajax:error", function(e, xhr, status, error) {
  return $("#new_rule").prepend("<p class='rule-length'>Must be a length of 6 or greater.</p>");
});



});
