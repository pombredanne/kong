local Object = require "classic"
local Mediator = require "mediator"
local utils = require "kong.tools.utils"

local Events = Object:extend()

Events.TYPES = {
  CLUSTER_PROPAGATE = "CLUSTER_PROPAGATE",
  ENTITY_CREATED = "ENTITY_CREATED",
  ENTITY_UPDATED = "ENTITY_UPDATED",
  ENTITY_DELETED = "ENTITY_DELETED"
}

function Events:new(plugins)
  self._mediator = Mediator()
end

function Events:subscribe(event_name, fn)
  self._mediator:subscribe({event_name}, fn)
end

function Events:publish(event_name, message_t)
  self._mediator:publish({event_name}, message_t)
end

return Events