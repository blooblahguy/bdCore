local bdCore, c, f = select(2, ...):unpack()

-- custom events/hooks
bd_action_events = bd_action_events or {}
function bd_add_action(event, func)
	local events = {strsplit(",", event)} or {event}
	-- print(#events)
	-- events = type(events) == "table" and events or {event}

	for k, e in pairs(events) do
		e = strtrim(e)
		if (not bd_action_events[e]) then
			bd_action_events[e] = {}
		end
		table.insert(bd_action_events[e], func)
	end
end
function bd_do_action(event,...)
	if (bd_action_events[event]) then
		for k, v in pairs(bd_action_events[event]) do
			v(...)
		end
	end
end

function bdCore:hookEvent(event, func) bd_add_action(event, func) end
function bdCore:triggerEvent(event, ...) bd_do_action(event, ...) end



function bdCore:redraw()
	bdCore:triggerEvent("bdcore_redraw")
end