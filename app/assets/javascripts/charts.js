$(document).ready(function() {
	$('.target-clear').change(function() {
		$.post($(this).data('href'), {
			target_clear: this.value,
		});
	});
	$('.target-priority').change(function() {
		$.post($(this).data('href'), {
			target_priority: this.value,
		});
	});
});
