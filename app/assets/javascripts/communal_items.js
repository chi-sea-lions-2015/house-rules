$(document).ready(function(){
	$("button.item_issue").click(function(e){
		e.preventDefault();
		var form = $(this).parent().find("form.item_issue");
		form.css("display", "block");
	});

	$("form.item_issue").submit(function(e){
		e.preventDefault();
		var form = $(this);
		$.ajax({
	      url: form.attr("action"),
	      method: form.attr("method"),
	      data: form.serialize(),
	      success: function(response){
	        $(".issue_body").append(response);
        	form[0].reset();
        	form.css("display","none");
      }
    });
	})
})