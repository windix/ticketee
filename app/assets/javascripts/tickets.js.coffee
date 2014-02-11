$(->
  $('a#add_another_file').click(->
    url = "/files/new?n=" + $('#files input').length
    $.get(url, 
      (data)->
        $('#files').append(data)
    )
  )
)