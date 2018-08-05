$(document).on("click", ".service-item", function () {
  var url =$(this).children().filter("a").attr("href")
  if (url && url.length){
    window.location = url
  }
})