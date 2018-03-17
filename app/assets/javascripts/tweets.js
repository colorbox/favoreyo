$(window).scroll(function(event) {
    var elements = $('p.container')
    elements.each(function() {
        var hT = this.offsetTop,
            hH = this.offsetHeight,
            wH = $(window).height(),
            wS = $(window).scrollTop();

        if (wS > (hT+hH-1.5*wH)) {
            $.get("tweets/" + this.id + ".js")
            this.className = "fetching-container"
        }
    });
});
