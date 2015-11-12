local event_types = require "kong.core.events".TYPES

local _M = {}

function _M.insert(collection, entity)
  ngx.log(ngx.DEBUG, " insert API action for \""..collection.."\"")

  local serf = require("kong.cli.services.serf")(configuration)
  serf:event({
    type = event_types.ENTITY_CREATED,
    data = {
      collection = collection,
      entity = entity
    }
  })
end

function _M.update(collection, old_entity, new_entity)
  ngx.log(ngx.DEBUG, " update API action for \""..collection.."\"")

  local serf = require("kong.cli.services.serf")(configuration)
  serf:event({
    type = event_types.ENTITY_UPDATED,
    data = {
      collection = collection,
      old_entity = old_entity,
      new_entity = entity
    }
  })
end

function _M.delete(collection, entity_deleted)
  ngx.log(ngx.DEBUG, " delete API action for \""..collection.."\"")

  local serf = require("kong.cli.services.serf")(configuration)
  serf:event({
    type = event_types.ENTITY_DELETED,
    data = {
      collection = collection,
      entity = entity_deleted
    }
  })
end

return _M