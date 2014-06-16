jQuery ->
  emailRegEx = new RegExp(/^((?!\.)[a-z0-9._%+-]+(?!\.)\w)@[a-z0-9-]+\.[a-z.]{2,5}(?!\.)\w$/i)
  emptyRegEx = new RegExp(/[-_.a-zA-Z0-9]{1,}/)
  numberRegEx = new RegExp(/^[0-9]{4}$/)
  drinkWindowRegEx = new RegExp(/^(20[0-9][0-9])$/)
  postalCodeRegEx = new RegExp(/^[A-Z]{1}[0-9]{1}[A-Z]{1} [0-9]{1}[A-Z]{1}[0-9]{1}/)
  drinkBeginAt = 2013
  drinkEndAt = 2099

  $('.container h2').on 'click', '.open_toggle', ->
    form = $(this).closest('.container').find('form')
    open_button = $(this).closest('.container h2').find('.open_toggle').find('i')
    form.slideToggle()
    if form.css('display') == 'none'
#      open_button.text(' Tasting Note')
    else
#      open_button.text(' Tasting Note')

  $('input[type="text"]').focus ->
    $('.respond_text').text('')

  $('textarea').focus ->
    $('.respond_text').text('')

  # click cancle button
  $('.form_outer').on 'click', 'button:reset', (e) ->
    e.preventDefault()
    form(this).slideToggle()

  # mouse over & out container
  $(".container.well.row").mouseenter (e) =>
    setBackgroundColor(e.currentTarget)

  $(".container.well.row").mouseleave (e) =>
    $(e.currentTarget).css('background', '#F5F5F5')
  #  $('#item_13').bind
  #    click: setBackgroundColor
  #    mouseleave: removeBackgroundColor

  $('.form_outer').on 'click', '.btn-primary', (e) ->
    e.preventDefault()
    form = $(this).closest('form')

    scrolInput = form.find('[name="test_paper[score]"]')
    drinkBeginAtInput = form.find('[name="test_paper[drink_begin_at]"]')
    drinkEndAtInput = form.find('[name="test_paper[drink_end_at]"]')
    scoreErrorMessage = '请输入这支酒的分数 Please enter a score.'

    if validate(scrolInput, emptyRegEx, scoreErrorMessage) # && validateDrinkWindow(drinkBeginAtInput, drinkEndAtInput, drinkWindowRegEx)
      form.submit()
      form.slideToggle('slow')
      #      form.closest('.container').find('h2 .label-success').removeClass('.label-success').addClass('.icon-remove').find()
      changeLabelStatus(form)
      changeNoteButtonState(form.closest('.container').find('.open_toggle'))
      $(this).closest('.container').effect("highlight",{color:"#fdfdb7"}, 3000)

  # 更新note的状态标志
  changeLabelStatus = (form) ->
    label = form.closest('.container').find('h2 .label')

    # Update Lable Score
    value = form.find('[name="test_paper[score]"]').val()
    label.find('i').text(value)

    unless label.hasClass('label-success')
      label.removeClass('label-important').addClass('label-success')
      label.find('i').removeClass('icon-remove').addClass('icon-ok')

  # 更新Note的编辑按钮状态
  changeNoteButtonState = (button) ->
    if button.hasClass('new_record')
      button.removeClass('new_record')
      button.find('i').removeClass('icon-file').addClass('icon-edit').text(' Edit Note')

  validate = (input, regex, error_message) ->
    if regex.test(input.val())
      removeErrorStyle(input)
      true
    else
      addErrorStyle(input, error_message)
      false

  validateDrinkWindowForNumber = (input, regex, error_message) ->
    if !input.val()
      removeErrorStyle(input)
      true
    else
      if regex.test(input.val())
        removeErrorStyle(input)
        true
      else
        addErrorStyle(input, error_message)
        false

  #  validateDrinkWindowMinAndMax = (input) ->
  #    if input.val() < 2013 && input.val() > 2099
  #      addErrorStyle(input)
  #      false
  #    else
  #      removeErrorStyle(input)
  #      true

  validateCompareDrinkWindow = (begin_at, end_at, error_message) ->
    if begin_at.val() && end_at.val()
      if begin_at.val() < end_at.val()
        removeErrorStyle(end_at)
        true
      else
        addErrorStyle(end_at, error_message)
        false
    else
      removeErrorStyle(end_at)
      true

  validateDrinkWindow = (begin_at_input, end_at_input, regex)->
    numberErrorMessage = '请输入正确的年份(2013~2099) Please enter a correct year(2013~2009).'
    compareErrorMessage = '开始年份大于结束年份 Please enter a further year.'
    validateDrinkWindowForNumber(begin_at_input, regex, numberErrorMessage) &&
    validateDrinkWindowForNumber(end_at_input, regex, numberErrorMessage)
  #    validateCompareDrinkWindow(begin_at_input, end_at_input, compareErrorMessage)


  for el in $('input[type="text"]')
    $(el).blur () ->
      removeErrorStyle($(this))
  # el
  controlGroup = (el) ->
    el.closest('.control-group')

  #el
  helpInline = (el)->
    controlGroup(el).find('.help-inline')

  addErrorStyle = (el, error_message) ->
    controlGroup(el).addClass('error')
    helpInline(el).text(error_message).show()

  removeErrorStyle = (el) ->
    controlGroup(el).removeClass('error')
    helpInline(el).hide()

  form = (click_el) ->
    $(click_el).closest('form')

  setBackgroundColor = (el) ->
    $(el).css('background', '#FFF')

  removeBackgroundColor = (el) ->
    $(el).css('background', '#F5F5F5')


  fixSidbarSelectItem = ->
    parent = $('.nav-list')
    current = $('.active')
    parent.scrollTop(parent.scrollTop() + current.position().top - parent.height()/2 + current.height()/2);


  # 左边导航所选的居中显示
  fixSidbarSelectItem()





