var fetchTracks = function(){
  $('[name=select_album]').change(function(){
    checkedAlbumId = $("input[name='select_album']:checked").val();
    $.ajax({
      headers: {
                  'Authorization': 'Bearer ' + gon.token
                },
      url: 'https://api.spotify.com/v1/albums/' + checkedAlbumId,
      success: function(response){
        resultsPlaceholder2.innerHTML = template2(response);
        $('#album_info').fadeIn();
      }
    });
  });
};
