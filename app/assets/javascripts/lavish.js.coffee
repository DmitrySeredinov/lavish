window.toggleSpinner = (show=true) ->
	$("div.spinner-container").toggle(show)
	if show
		$("#spinner").spin({
			lines: 15
			length: 20
			width: 8
			radius: 30
			corners: 1
			speed: 1
			color: '#fff'
		})
	else
		$("#spinner").spin(false)

window.submitColors = ->
	toggleSpinner(true)
	$('#customize-form').submit()

window.saveFile = (filename, content) ->
	saveAs(
		new Blob([content], {type: "text/plain;charset=" + document.characterSet}),
		filename
	)

window.insertLavish = (raw) ->
	$('#sass-code').val(lavishVariables)
	$('#css-code').val(lavishCSS)
	$('#lavish-style').text(lavishCSS)
	toggleSpinner(false)

$(document).ready ->
	$('.select-color').on 'click', ->
		val = $('.value', this).text()
		$label = $('.color-label', $(this).closest('.btn-group'))
		$('.selected-color', $label).css({"background-color": val})
		$('.selected-value', $label).text(val)
		$("input[data-index='#{$(this).data('index')}']").val(val)
		$(this).closest('.btn-group').removeClass('open')
		submitColors()
		false

	$('.color-input, input.jscolor').on 'change', ->
		submitColors()

	$("#variables-download").click (event) ->
		event.preventDefault()
		saveFile("variables.scss", lavishVariables)

	$("#css-download").click (event) ->
		event.preventDefault()
		saveFile("lavish-bootstrap.css", lavishCSS)
