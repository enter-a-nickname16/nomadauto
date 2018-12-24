$(function(){
  if ( $(window).width() > 767) {
    //Add your javascript for large screens here
    $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("active");
    });
  }
});
