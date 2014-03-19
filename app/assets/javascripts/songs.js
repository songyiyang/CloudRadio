$(document).ready(function(){
  // var url = 'https://api.soundcloud.com/tracks.json?client_id=ae9f52f98895e6a3663870f4de3549a5';
  // $.getJSON(url, function(tracks) {
  // });
  $('#three').click(function(event){
    $.ajax({
        url: "/homepage/",
        type: "GET",
        dataType: 'json',
        success: function(data){
          $('#one').empty();
          $('#one').append("<iframe width='60%' height='400' scrolling='no' frameborder='no' src='" + data.embed_http + "&auto_play=true' ></iframe>");
        }
    });
  });

  $('#unlike').click(function(event){
    var songId = this.getAttribute("data-song");
    $.ajax({
        url: "/songs/" + songId + "/unlike/",
        type: "GET",
        dataType: 'json',
        success: function(data){
          $('#one').empty();
          $('#one').append("<iframe width='60%' height='400' scrolling='no' frameborder='no' src='" + data.embed_http + "&auto_play=true' ></iframe>");
        }
    });
  });

});
