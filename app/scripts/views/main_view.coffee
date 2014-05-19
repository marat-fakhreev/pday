class App.Views.MainView
  MOVING_DURATION = 1500
  LIST_LENGTH = 3
  HEIGHT = 0
  SHORT_HEIGHT = 0
  ITTER = 0
  WIDTH = 0
  DATE = [2014, 5, 21]

  constructor: ->
    @initUi()
    @events()
    @_initReviewList()
    @_setDate()
    @_initPhotoalbum()
    @count = @ui.photoalbumInner.find('img').length

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
      photoalbumInner: $('.photoalbum-inner')
      img: $('.photoalbum-inner img')
      photoBtn: $('.p-button')

  events: ->
    @ui.regButton.on 'click', (=> @moveToElem(@ui.regScreen, 150))
    @ui.aboutButton.on 'click', (=> @moveToElem(@ui.aboutScreen, 0))
    @ui.presentersButton.on 'click', (=> @moveToElem(@ui.aboutScreen, 1000))
    @ui.scrollButton.on 'click', (=> @moveToElem(@ui.scrollScreen, 0))
    @ui.reviewShowButton.on 'click', @showReviews
    @ui.photoBtn.on 'click', @slidePhoto
    # @ui.form.on 'submit', @registrationForm

  moveToElem: (element, height) ->
    @ui.body.animate(scrollTop: @_getFromTop(element, height), MOVING_DURATION, 'easeInOutCirc')

  showReviews: =>
    @ui.reviewShowButton.toggleClass('active')

    if @ui.reviewShowButton.hasClass('active')
      @ui.reviewShowButton.html('Скрыть все отзывы')
      @ui.reviewList.animate(height: HEIGHT, 700)
    else
      @ui.reviewShowButton.html('Раскрыть все отзывы')
      @ui.reviewList.animate(height: SHORT_HEIGHT, 700)

  slidePhoto: (event) =>
    self = $(event.currentTarget)
    width = 0

    if self.hasClass('left-button')
      ITTER-- if ITTER > 0
    else if self.hasClass('right-button')
      ITTER++ if ITTER < @count

    for i in [0...ITTER]
      width += @ui.img.eq(i).width()

    if width > WIDTH
      @ui.photoalbumInner.stop().animate('left': -WIDTH, 300)
    else
      @ui.photoalbumInner.stop().animate('left': -width, 300)

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
    @ui.img.each ->
      WIDTH += $(@).width()

    WIDTH = WIDTH - $(document).width()
    # width = @ui.photoalbumInner.width() - $(document).width()

    # @ui.photoalbumInner.draggable axis: 'x', stop: (event, ui) =>
    #   if ui.position.left > 0
    #     @ui.photoalbumInner.animate('left': '0px', 300)
    #   else if ui.position.left < -width
    #     @ui.photoalbumInner.animate('left': -width, 300)
