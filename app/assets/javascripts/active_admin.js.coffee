#= require active_admin/base
#= require select2

$(document).ready ->
  $('.select2able').select2({
    width: '80%'
  })

  promocodable_select = $('#promocodable_select')
  ticket_type_select = $('#ticket_type_select')

  promocodable_select.select2({
    width: '80%'
  })

  promocodable_select.on 'change', (e) ->
    $.ajax({
      url: '/admin/ticket_types.json?event_id=' + @value,
      method: 'GET',
      datatype: 'json',
      success: (data) ->
        s = '<option value=""></option>'
        data.forEach (ticket) ->
          s += '<option value="' + ticket.id + '">' + ticket.title + '</option>'
        ticket_type_select.html(s)
    })