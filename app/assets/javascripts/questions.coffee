# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#jQuery(document).ready(function($) {
#    $(".clickable-row").click(function() {
#        window.document.location = $(this).data("href");
#    });
#});

$ ->
  $(".clickable-row").click (e) ->
    window.location = $(this).data("href")
