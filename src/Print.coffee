Utils = require "./Utils"

print = (args...)->
	message 		= '» '+args.map((obj) -> Utils.inspect(obj)).join(", ")
	sameOrigin 	= undefined

	if Utils.isEmbed()
		try
			sameOrigin = window.parent.location.host is window.location.host
		catch e
			sameOrigin = undefined
		return if not sameOrigin
		window.top._console.push message
		if window.top._refreshConsole isnt undefined
			window.top._refreshConsole()
	else
		console.log message
	return

# Speed debugging
print._times = {}
print.time = (name)->
	print._times[name] = window.performance.now()
	return
print.timeEnd = (name)->
	return if not log._times[name]
	print Utils.round(window.performance.now()-print._times[name], 2)+'ms'
	return

module.exports = print
