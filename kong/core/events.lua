local Object = require "classic"
local Mediator = require "mediator"
local utils = require "kong.tools.utils"

local Events = Object:extend()

Events.TYPES = {
  ENTITY_CREATED = "ENTITY_CREATED",
  ENTITY_UPDATED = "ENTITY_UPDATED",
  ENTITY_DELETED = "ENTITY_DELETED"
}

function Events:new(plugins)
  self._mediator = Mediator()

  -- Attach hooks for every plugin
  for _, plugin in ipairs(plugins) do
    local loaded, plugin_hooks = utils.load_module_if_exists("kong.plugins."..plugin.name..".hooks")
    if loaded then
      for k, v in pairs(plugin_hooks) do
        self._mediator:subscribe({k}, v)
      end
    end
  end
end

function Events:publish(event_name, message_t)
  self._mediator:publish({event_name}, message_t)
end

return Events