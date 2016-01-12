# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('input.question.form-radio').click ->
    $(this).parent('.radio-label').addClass 'active'
    $(this).parent('.radio-label').siblings().removeClass 'active'
    return
  return