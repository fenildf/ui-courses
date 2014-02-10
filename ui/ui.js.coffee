load_chapter = (chapter_name)->
  url = "#{chapter_name}/1.html"
  jQuery.ajax
    url: url
    method: 'GET'
    success: (res)=>
      $res = jQuery("<div>#{res}</div>")
      $play = $res.find('.play')
      $desc = $res.find('.desc')

      jQuery('.paper .p').html $play
      jQuery('.paper .d').html $desc

      console.log $res

jQuery ->
  load_chapter('chapter1')