$(document).ready(function(){
  $("a.postfix").click(function(e){
    e.preventDefault();
debugger;
    var data = $("form#search-form").find("#search").val();
    var form = $("form#search-form");

    $.get("/houses/search/"+data).done(function(response){

      var housesListContainer = $("#houses-container");
      housesListContainer.html("");

      if (response=="No") {
        $("#search").css('border','1px solid red');
        form[0].reset();
      } else {
        $("#search").css('border','1px solid $333');
        var template = _.template('<%= name %> <a href="/houses/<%= id %>">Join</a><br>');
        response.forEach(function(houseData){
        housesListContainer.prepend(template(houseData));
        form[0].reset();
      })       
      }
    })
  })
})