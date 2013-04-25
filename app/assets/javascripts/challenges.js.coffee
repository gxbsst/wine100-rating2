jQuery ->
  $('.form_outer').on 'click', '.open_toggle', -> 
    form = $(this).closest('.form_outer').find('form')
    open_button = $(this).closest('.form_outer').find('.open_toggle').find('i')
    form.slideToggle()
    if form.css('display') == 'none'
      open_button.text(' 写拼酒辞')
    else
      open_button.text(' 写拼酒辞')

  $('input[type="text"]').focus ->
      $('.respond_text').text('')

  $('textarea').focus ->
      $('.respond_text').text('')

  $('.form_outer').on 'click', '.btn', (e) ->
      e.preventDefault()
      form = $(this).closest('form')
      form.submit()
      form.slideToggle('slow')
      $(this).closest('.container').effect("highlight",{color:"#fdfdb7"}, 3000)
      # table.effect("highlight", {}, 3000)





