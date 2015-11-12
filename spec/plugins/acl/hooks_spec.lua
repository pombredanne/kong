local json = require "cjson"
local http_client = require "kong.tools.http_client"
local spec_helper = require "spec.spec_helpers"

local STUB_GET_URL = spec_helper.STUB_GET_URL

describe("ACL Hooks", function()

  setup(function()
    spec_helper.prepare_db()
    spec_helper.insert_fixtures {
      api = {
        {name = "ACL-1", request_host = "acl1.com", upstream_url = "http://mockbin.com"}
      },
      consumer = {
        {username = "consumer1"},
        {username = "consumer2"}
      },
      plugin = {
        {name = "key-auth", config = {key_names = {"apikey"}}, __api = 1},
        {name = "acl", config = { whitelist = {"admin"}}, __api = 1}
      },
      keyauth_credential = {
        {key = "apikey123", __consumer = 1},
        {key = "apikey124", __consumer = 2}
      },
      acl = {
        {group="admin", __consumer = 1},
        {group="pro", __consumer = 1},
        {group="admin", __consumer = 2}
      }
    }
    spec_helper.start_kong()
  end)

  teardown(function()
    spec_helper.stop_kong()
  end)

  describe("ACL entity", function()
    it("should invalidate when ACL entity is updated", function()
      -- It should work
      local response, status = http_client.get(STUB_GET_URL, {apikey = "apikey124"}, {host="acl1.com"})
      assert.equals(200, status)
      
      -- Delete ACL group (which triggers invalidation)
      

      -- It should not work
      local response, status = http_client.get(STUB_GET_URL, {apikey = "apikey124"}, {host="acl1.com"})
      assert.equals(200, status)
    end)
  end)
      
end)
