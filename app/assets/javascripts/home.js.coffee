# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $(".find").on "click", ->
    $.getJSON "/alert", id: $(this).data("id")

  $(".color").minicolors
      theme: 'bootstrap'
      change: (color) ->
        $.getJSON "/color", id: $(this).data("id"), color: color

  $('.brightness').each (index, elem) ->
    $(elem).slider().on "slide", (event) ->
      $.getJSON "/brightness", id: $(this).data("id"), bri: event.value

  $('input[type=checkbox]').bootstrapSwitch(

  ).on 'switchChange.bootstrapSwitch', (event, state) ->
    if state
      $.getJSON "/on", id: $(this).data("id")
    else
      $.getJSON "/off", id: $(this).data("id")
