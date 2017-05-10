$(document).on('turbolinks:load', function () {
  $('.showmodal').click(function (e) {
    e.preventDefault()
    if (gon.user) {

      $('.modal').toggleClass('is-active')
      // get that flavour id
      // alert('flavor id is ' + this.id)
      $('#order_flavour_id').attr('value', this.id)
      // because we need to pass that id into the the form
      $('#flavourimage').text(this.name)
    } else {

    }
  })

  $('button.delete').click(function () {
    $('.modal').toggleClass('is-active')
  })

  $('#formorder').click(function () {
    $('.modal').toggleClass('is-active')
  })

  $('#cancel').click(function () {
    $('.modal').toggleClass('is-active')
  })
})
