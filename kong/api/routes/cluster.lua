local responses = require "kong.tools.responses"
local constants = require "kong.constants"
local cjson = require "cjson"



return {
  ["/cluster/"] = {
    GET = function(self, dao_factory)
      local serf = require("kong.cli.services.serf")(configuration)
      local res, err = serf:invoke_signal("members", { ["-format"] = "json" })
      if err then
        return responses.send_HTTP_INTERNAL_SERVER_ERROR(err)
      else
        local members = cjson.decode(res).members
        for _, v in ipairs(members) do
          v.tags = nil
          v.protocol = nil
        end
        return responses.send_HTTP_OK(members)
      end
    end,

    POST = function(self, dao_factory)
      local serf = require("kong.cli.services.serf")(configuration)
      if self.params.address then
        local _, err = serf:invoke_signal("join", { self.params.address })
        if err then
          return responses.send_HTTP_BAD_REQUEST(err)
        else
          return responses.send_HTTP_OK()
        end
      else
        return responses.send_HTTP_BAD_REQUEST("Missing \"address\"")
      end
    end
  },
  ["/cluster/events/"] = {
    POST = function(self, dao_factory)
      local operation = self.params.operation
      
      if operation and (operation == constants.ENTITY_UPDATED or operation == constants.ENTITY_DELETED) then
        -- Invoke plugin's invalidation

        -- TODO

      end

      return responses.send_HTTP_OK()
    end
  }
}
