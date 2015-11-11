local Mediator = require "lua_mediator"

local KongEvents = Object:extend()

function KongEvents:new()
  self.mediator = Mediator()
end

function KongEvents:attach_hooks(plugins)
  for ... plugins do
    -- test if plugin has hooks.lua
    if then
      -- iterator over hooks, and atdd them as subscribeers (?) to mediator
    end
  end
end

function KongEvents:pub(event_name, ...)

end

KongEvents.EVENTS = {
  ENTITY_CREATED = "ENTITY_CREATED",
  -- ...
}

return KongEvents