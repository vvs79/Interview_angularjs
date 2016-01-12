$(window).scroll ->
  if $(window).scrollTop() > 120
    $('#summary-drop-list').addClass('list-fixed')
  else
    $('#summary-drop-list').removeClass('list-fixed')
  return

shiftWindow = ->
  scrollBy 0, -90
  return

if location.hash
  shiftWindow()
window.addEventListener 'hashchange', shiftWindow

