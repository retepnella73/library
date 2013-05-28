# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#genre_category_id").change ->
    $.ajax
      url: "/genres"
      data:
        category_id: $("#genre_category_id").val()
      dataType: "script"


