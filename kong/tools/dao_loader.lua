local _M = {}

function _M.load(parsed_config)
  local DaoFactory = require("kong.dao."..parsed_config.database..".factory")
  return DaoFactory(parsed_config.dao_config, parsed_config.plugins_available)
end

return _M
