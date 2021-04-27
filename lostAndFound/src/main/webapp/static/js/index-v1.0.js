if ($('footer').width() > 900) {
	$(function() {
		var elm = $('nav');
		var startPos = 200;
		$.event.add(window, "scroll", function() {
			var p = $(window).scrollTop();
			$(elm).css('position', ((p) > startPos) ? 'fixed' : '');
			$(elm).css('top', ((p) > startPos) ? '0' : '');
			$(elm).css('opacity', ((p) > startPos) ? '0.8' : '');
		});
	});
}