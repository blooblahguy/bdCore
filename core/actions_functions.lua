local bdCore, c, f = select(2, ...):unpack()

-- custom events/hooks
bdCore.events = {}
function bdCore:hookEvent(event, func)
	local events = split(event,",") or {event}
	for i = 1, #events do
		e = events[i]
		if (not bdCore.events[e]) then
			bdCore.events[e] = {}
		end
		bdCore.events[e][#bdCore.events[e]+1] = func
	end
end

function bdCore:triggerEvent(event,...)
	if (bdCore.events[event]) then
		for k, v in pairs(bdCore.events[event]) do
			v(...)
		end
	end
end

function bdCore:redraw()
	bdCore:triggerEvent("bdcore_redraw")
end