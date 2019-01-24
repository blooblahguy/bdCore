local bdCore, c, f = select(2, ...):unpack()

-- custom events/hooks
bd_action_events = bd_action_events or {}
function bd_add_action(event, func)
	local events = strsplit(",", event) or {event}
	events = type(events) == "table" and events or {event}

	for i = 1, #events do
		e = events[i]
		if (not bd_action_events[e]) then
			bd_action_events[e] = {}
		end
		bd_action_events[e][#bd_action_events[e]+1] = func
	end
end
function bd_do_action(event,...)
	if (bd_action_events[event]) then
		for k, v in pairs(bd_action_events[event]) do
			v(...)
		end
	end
end

bdCore.hookEvent = bd_add_action
bdCore.triggerEvent = bd_do_action



function bdCore:redraw()
	bdCore:triggerEvent("bdcore_redraw")
end