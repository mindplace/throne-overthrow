$(document).ready(function(){
  $("#edit").on('click', function(e){
    e.preventDefault();

    $("#editform").show();
  });

  $("#editform").on('submit', function(e){
    e.preventDefault();
    question_id = $(this).parent().attr('id');
    var data = $(e.target).serialize();
    var url = e.target.action;
    var type = e.target.method;
    $.ajax({
      data: data,
      url: url,
      type: type
    }).done(function(response){
      $("#" + question_id).html(response);
    });
  });

  $("#new-question-button").on('click',function(e){
    e.preventDefault();
    $(this).hide();
    $("#popup-new-question").show();
  });

  $("#question-answer-parent").on('submit', '.new-comment',function(e) {
    e.preventDefault();
    var target = e.target;
    var type = target.method;
    var url = target.action;
    var data = $(target).serialize();

    $.ajax({
      type: type,
      url: url,
      data: data
    }).done(function(response) {
      var id = e.target.parentElement.getAttribute("id")
      if (data.indexOf('Question') >= 0) {

        $('#question-comments-container').append(response);
      }
      else {
        $(target).parent().parent().append(response);
      }
    });
  });

  $('#new-answer-container').on( 'submit', '.new-answer-form', function(e) {
    e.preventDefault()
    var target = e.target;
    var type = target.method;
    var url = target.action;
    var data = $(target).serialize();

    $.ajax({
      type: type,
      url: url,
      data: data
    }).done(function(response) {
      $('#question-answers-container').append(response)
    })
  })
});
