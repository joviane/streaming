// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function() {
  setTimeout(function() {
    var source = new EventSource('/stream');
    source.addEventListener('update', function(event) {
      $('.streaming').append(event.data);
    });
  }, 1);
});
