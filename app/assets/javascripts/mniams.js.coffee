$(document).ready ($) ->
 $container = $("#mniams")
 setTimeout (-> $container.masonry
      itemSelector: '.box'
      isFitWidth: true), 
  200
