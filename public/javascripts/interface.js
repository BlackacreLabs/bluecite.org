// Generated by CoffeeScript 1.4.0
(function() {

  $().ready(function() {
    var SPINNER;
    SPINNER = '<img src="/img/spinner.gif" alt="Loading">';
    ZeroClipboard.setDefaults({
      moviePath: '/ZeroClipboard.swf'
    });
    new ZeroClipboard($('#abbreviationclip'));
    $('#abbreviationClip').click(function() {
      return null;
    });
    $('#abbreviate').submit(function() {
      var output, values;
      values = $(this).serialize();
      output = $('#abbreviationOutput').html(SPINNER);
      $.getJSON('/abbreviate', values, function(data) {
        return output.text(data.text);
      });
      return false;
    });
    new ZeroClipboard($('#dateClip'));
    $('#datePicker').datepicker().on('changeDate', function(e) {
      var output;
      output = $('#dateOutput').html(SPINNER);
      $.getJSON('/date', {
        text: e.date.toISOString()
      }, function(data) {
        return output.text(data.text);
      });
      return false;
    });
    return $('button.copy').tooltip();
  });

}).call(this);
