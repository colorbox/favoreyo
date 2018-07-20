$(window).scroll(function(event) {
  if ($("#next").length==0) { return }
  var element = $("#next")
  var hT = element.offset().top,
      wH = $(window).height(),
      wS = $(window).scrollTop();

  // hT position get down and down with loading
  // 1.5 times window height has two meaning
  // 1. preload tweets
  // 2. not to make hT position going avoid loading
  if (hT < (wS + wH * 1.5)) {
    element.attr("id", "fetching-next")
    $.get("tweets.js?last=" + element.attr("last_id"))
  }
});
