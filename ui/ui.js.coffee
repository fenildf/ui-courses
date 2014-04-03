documents = {
  'chapter1' : 15
}

load_chapter = (chapter_name, page)->
  load_chapter_and_page(chapter_name, 1)

load_chapter_and_page = (chapter_name, page)->
  url = "#{chapter_name}/#{page}.html?#{Math.random()}"

  jQuery.ajax
    url: url
    method: 'GET'
    success: (res)=>
      $res = jQuery("<div>#{res}</div>")
      $play = $res.find('.play')
      $desc = $res.find('.desc')

      jQuery('.document .p').html $play
      jQuery('.document .d').html $desc

      change_pager(chapter_name, page)

      prettyPrint()

change_pager = (chapter_name, page)->
  console.log chapter_name, page

  jQuery('.pager')
    .data('page', page)
    .data('chapter', chapter_name)

  if page == 1
    jQuery('.pager .prev').addClass('disabled')
    jQuery('.pager .next').removeClass('disabled')
    return

  if page == documents[chapter_name]
    jQuery('.pager .prev').removeClass('disabled')
    jQuery('.pager .next').addClass('disabled')
    return

  jQuery('.pager .prev').removeClass('disabled')
  jQuery('.pager .next').removeClass('disabled')

push_state = (chapter, page) ->
  state_url = window.location.href.split('#')[0] + "##{chapter}/#{page}"
  state = {
    chapter: chapter,
    page: page
  }
  window.history.pushState(state, document.title, state_url)

jQuery ->
  window.addEventListener 'popstate', (e)->
    if history.state
      load_chapter_and_page(e.state.chapter, e.state.page)

  window_url = window.location.href
  page_info = window_url.split('#')[1]

  if !page_info
    load_chapter('chapter1')
  else
    p = page_info.split('/')
    load_chapter_and_page(p[0], parseInt(p[1]))

  # --------------------------

  jQuery('.pager .next').on 'click', ->
    return if jQuery(this).hasClass('disabled')

    current_chapter = jQuery('.pager').data('chapter')
    current_page = jQuery('.pager').data('page')
    
    load_chapter_and_page(current_chapter, current_page + 1)

    push_state(current_chapter, current_page + 1)


  jQuery('.pager .prev').on 'click', ->
    return if jQuery(this).hasClass('disabled')

    current_chapter = jQuery('.pager').data('chapter')
    current_page = jQuery('.pager').data('page')
    
    load_chapter_and_page(current_chapter, current_page - 1)

    push_state(current_chapter, current_page - 1)