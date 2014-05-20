class App.Views.MainView
  MOVING_DURATION = 1500
  LIST_LENGTH = 3
  HEIGHT = 0
  SHORT_HEIGHT = 0
  DATE = [2014, 5, 21]

  constructor: ->
    @initUi()
    @events()
    @_initReviewList()
    @_setDate()
    @_initPhotoalbum()

  initUi: ->
    @ui =
      body: $('body')
      form: $('#registration_form')
      field: $('.field input')
      scrollButton: $('.scroll-button')
      scrollScreen: $('.scroll-screen')
      presentersButton: $('.presenters-button')
      aboutButton: $('.about-button')
      aboutScreen: $('.about-screen')
      regButton: $('.reg-button')
      regScreen: $('.registration-screen')
      reviewShowButton: $('#show_list_button')
      reviewList: $('#review_list')
      reviewListItem: $('#review_list li')
      daysCount: $('.days-count')
      photoalbum: $('#photoalbum')

  events: ->
    @ui.regButton.on 'click', (=> @moveToElement(@ui.regScreen, 150))
    @ui.aboutButton.on 'click', (=> @moveToElement(@ui.aboutScreen, 0))
    @ui.presentersButton.on 'click', (=> @moveToElement(@ui.aboutScreen, 1000))
    @ui.scrollButton.on 'click', (=> @moveToElement(@ui.scrollScreen, 0))
    @ui.reviewShowButton.on 'click', @showReviews

  moveToElement: (element, height) ->
    @ui.body.animate(scrollTop: @_getFromTop(element, height), MOVING_DURATION, 'easeInOutCirc')

  showReviews: =>
    @ui.reviewShowButton.toggleClass('active')

    if @ui.reviewShowButton.hasClass('active')
      @ui.reviewShowButton.html('Скрыть все отзывы')
      @ui.reviewList.animate(height: HEIGHT, 700)
    else
      @ui.reviewShowButton.html('Раскрыть все отзывы')
      @ui.reviewList.animate(height: SHORT_HEIGHT, 700)

  _getFromTop: (element, height) ->
    element.offset().top + height

  _setDate: ->
    targetDate = moment(DATE)
    today = moment().format()
    daysCount = targetDate.diff(today, 'days')
    lastChar = daysCount.toString().slice(-1)

    if lastChar is '1'
      text = 'день'
    else if lastChar is '2' or lastChar is '3' or lastChar is '4'
      text = 'дня'
    else
      text = 'дней'

    @ui.daysCount.find('span').html(daysCount)
    @ui.daysCount.find('p').html(text)

  _initReviewList: ->
    itter = 1

    @ui.reviewListItem.each ->
      HEIGHT += $(@).height() + 40
      SHORT_HEIGHT = HEIGHT if itter is LIST_LENGTH
      itter++

    @ui.reviewList.height(SHORT_HEIGHT)

  _initPhotoalbum: ->
    @ui.photoalbum.smoothTouchScroll()
