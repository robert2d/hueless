require 'huey'

begin
  Huey::Request.register
rescue
  bridge = Huey::Bridge.new
  bridge.link!
end
