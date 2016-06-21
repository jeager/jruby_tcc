# Close the dropdown menu if the user clicks outside of it

myFunction = ->
  document.getElementById('myDropdown').classList.toggle 'show'
  return

window.onclick = (event) ->
  if !event.target.matches('.dropbtn')
    dropdowns = document.getElementsByClassName('dropdown-content')
    i = undefined
    i = 0
    while i < dropdowns.length
      openDropdown = dropdowns[i]
      if openDropdown.classList.contains('show')
        openDropdown.classList.remove 'show'
      i++
  return