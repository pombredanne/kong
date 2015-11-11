local constants = require "kong.constants"

local _M = {}

function _M.insert(collection, entity)
  ngx.log(ngx.DEBUG, " insert API action for \""..collection.."\"")

  local serf = require("kong.cli.services.serf")(configuration)
  serf:event({
    type = constants.ENTITY_CREATED,
    collection = collection,
    properties = {
      entity = entity
    }
  })
end

function _M.update(collection, old_entity, new_entity)
  ngx.log(ngx.DEBUG, " update API action for \""..collection.."\"")

  local serf = require("kong.cli.services.serf")(configuration)
  serf:event({
    operation = constants.ENTITY_UPDATED,
    collection = collection,
    old_entity = old_entity,
    new_entity = entity
  })
end

function _M.delete(collection, where_t)
  ngx.log(ngx.DEBUG, " delete API action for \""..collection.."\"")

  local serf = require("kong.cli.services.serf")(configuration)
  serf:event({
    operation = constants.ENTITY_DELETED,
    collection = collection,
    where_t = where_t
  })
end

return _M