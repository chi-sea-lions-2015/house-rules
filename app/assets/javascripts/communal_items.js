$(document).ready(function(){
	$(document).on("click", "img.issue-mark", function(e){
		e.preventDefault();
		debugger;
		var form = $(this).parent().parent().find("form.item_issue");
		if (form.css("display")=="none"){
			form.css("display", "block");
		} else {
			form.css("display", "none");
		}
	});

	$("form.item_issue").submit(function(e){
		e.preventDefault();
		debugger;
		var form = $(this);
		var list = form.parent().parent().find(".issue-content");
		$.ajax({
	      url: form.attr("action"),
	      method: form.attr("method"),
	      data: form.serialize(),
	      success: function(response){
	        list.prepend(response);
        	form[0].reset();
        	form.css("display","none");
      	  }
    	});
	})
})
