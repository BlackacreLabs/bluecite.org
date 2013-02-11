$().ready ->
  SPINNER = '<img src="/img/spinner.gif" alt="Loading">'

  ZeroClipboard.setDefaults moviePath: '/ZeroClipboard.swf'
  new ZeroClipboard $('#abbreviationclip')
  $('#abbreviationClip').click -> return null
  $('#abbreviate').submit ->
    values = $(this).serialize()
    output = $('#abbreviationOutput').html(SPINNER)
    $.getJSON '/abbreviate', values, (data) ->
      output.text(data.text)
    return false

  new ZeroClipboard $('#dateClip')
  $('#datePicker').datepicker().on 'changeDate', (e) ->
    output = $('#dateOutput').html(SPINNER)
    $.getJSON '/date', {text: e.date.toISOString()}, (data) ->
      output.text(data.text)
    return false

  $('button.copy').tooltip()
