$(document).pjax('#article-tabs a', {
  container: '#articles-container'
#  url: ()->
#    url = $(this.target).closest("li").attr("data-url")
#    console.log "url: ", url
#
#    return url
#    #$(this).attr("data-url")
})


$("#article-tabs li a").on "pjax:clicked", ()->
  $("#article-tabs li").removeClass("active")
  $li = $(this).closest("li")
  $li.addClass("active")
  breadcrumb = $li.attr("data-breadcrumb")
  $(".breadcrumbs li:last-child span").text(breadcrumb)
  console.log "breadcrumb: ", breadcrumb