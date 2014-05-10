class App.Views.MainView
  DURATION = 1500
  LIST_LENGTH = 3
  HEIGHT = 120
  SHORT_HEIGHT = 0

  constructor: ->
    @initUi()
    @events()
    @_initReviewList()

  initUi: ->
    @ui =
      body: $('body')
      form: $('#registration_form')
      field: $('.field input')
      regButton: $('.reg-button')
      regScreen: $('.registration-screen')
      reviewShowButton: $('#show_list_button')
      reviewList: $('#review_list')
      reviewListItem: $('#review_list li')

  events: ->
    @ui.regButton.on 'click', @moveToForm
    @ui.reviewShowButton.on 'click', @showReviews
    @ui.form.on 'submit', @registrationForm

  moveToForm: =>
    @ui.body.animate(scrollTop: @_getFromTop(), DURATION, 'easeInOutCirc')

  showReviews: =>
    @ui.reviewShowButton.toggleClass('active')

    if @ui.reviewShowButton.hasClass('active')
      @ui.reviewShowButton.html('Скрыть все отзывы')
      @ui.reviewList.animate(height: HEIGHT + 20, 300)
    else
      @ui.reviewShowButton.html('Раскрыть все отзывы')
      @ui.reviewList.animate(height: SHORT_HEIGHT, 300)

  registrationForm: (event) =>
    event.preventDefault()
    flag = true
    data = {}

    @ui.field.each ->
      flag = false if $(@).val() is ''

    if flag
      @ui.field.each ->
        self = $(@)
        data[self.attr('name')] = self.val()
      new App.Models.RegistrationModel(data)
    else
      alert('Пожалуйста заполните все поля!')

  _getFromTop: ->
    @ui.regScreen.offset().top + 150

  _initReviewList: ->
    itter = 1

    @ui.reviewListItem.each ->
      HEIGHT += $(@).height()
      SHORT_HEIGHT = HEIGHT if itter is LIST_LENGTH
      itter++

    @ui.reviewList.height(SHORT_HEIGHT)
