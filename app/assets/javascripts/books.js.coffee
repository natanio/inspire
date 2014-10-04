# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#books, #books2').imagesLoaded ->
		$('#books, #books2').masonry
			itemSelector: '.books-box'
			isFitWidth: true