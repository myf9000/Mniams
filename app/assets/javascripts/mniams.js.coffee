$ ->
  $('#mniams').imagesLoaded ->
    $('#mniams').masonry
      itemSelector: '.box'
      isFitWidth: true