# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

rgbToHex = (r, g, b) ->
  return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)

$ ->

  Webcam.attach( '#my_camera' )

  $(".target-image").on "click", (event) ->
    colorThief = new ColorThief()
    palette = colorThief.getPalette($(this)[0])
    $(".bulb .color").each (index, elem) ->
      color = rgbToHex(palette[index][0], palette[index][1], palette[index][2])
      $(elem).minicolors("value", color)


  setInterval ->
    Webcam.snap (data_uri) ->
      document.getElementById('my_result').innerHTML = '<img src="'+data_uri+'"/>'
      colorThief = new ColorThief()
      color = colorThief.getColor($("#my_result img")[0])
      xy = colors.rgbToCIE1931(color[0], color[1], color[2])
      $.getJSON "/xy", id: "all", x: xy[0], y: xy[1]
  , 2000

  # index = 0

  # setInterval ->
  #   $($(".target-image").get(index)).click()
  #   # $('.brightness').each (index, elem) ->
  #     #$(elem).slider("setValue", 255)
  #   index++
  #   if index == $(".target-image").length
  #     index = 0
  # , 60000 * 3

  $(".find").on "click", (e) ->
    e.preventDefault()
    $.getJSON "/alert", id: $(this).data("id")

  $(".color").minicolors
      theme: 'bootstrap'
      color: "saturation"
      change: (color) ->
        $.getJSON "/color", id: $(this).data("id"), color: color

  ready = true
  $('.brightness').each (index, elem) ->
    $(elem).slider().on "slide", (event) ->
      if ready
        ready = false
        $.getJSON "/brightness", id: $(this).data("id"), bri: event.value
        setTimeout ->
          ready = true
        , 200

  $('input[type=checkbox]').bootstrapSwitch(

  ).on 'switchChange.bootstrapSwitch', (event, state) ->

    if state
      $.getJSON "/on", id: $(this).data("id")
    else
      $.getJSON "/off", id: $(this).data("id")
