local events = require "kong.core.events"

return {
  [events.TYPES.ENTITY_CREATED] = function(message_t)
    print("HELLO")
  end
}