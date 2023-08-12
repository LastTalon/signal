local Package = script.Parent
local LinkedList = require(Package.LinkedList)

--[=[
	Disconnects this connection.

	```lua
	local connection = signal:Connect(callback)
	connection.disconnect()
	```

	@function disconnect
	@within Connection
]=]

--[=[
	Checks if this function is currently connected.

	```lua
	local connection = signal:Connect(callback)

	if connection.isConnected() then
		print("We are connected!")
	end
	```

	@return boolean

	@function isConnected
	@within Connection
]=]

--[=[
	A connection created by an [Event] or [Signal].

	@class Connection
]=]
export type Connection = {
	disconnect: () -> (),
	isConnected: () -> boolean,
}

--[=[
	A function called when an Event fires.

	@type Callback (...unknown) -> ()
	@within Signal
]=]
export type Callback = (...unknown) -> ()

type Listener = {
	callback: Callback,
	connection: Connection,
}

--[=[
	A Signal for firing events to subscribing listeners.

	@class Signal
]=]
local Signal = {}
Signal.__index = Signal

--[=[
	Creates a new Signal.

	@return Signal
]=]
function Signal.new()
	local signal = setmetatable({}, Signal)

	--[=[
		An Event that you can subscribe to.

		This is effectively the subscription end of a [Signal]. This is primarily
		used to provide subscription to external consumers of a Signal. For example,
		you may want to provide a Signal that can be subscribed to, but not fired.

		@class Event
	]=]
	local Event = {}
	Event.__index = Event

	--[=[
		Connect a [Callback] to this Event.

		The Callback will be called every time this Event fires. It can be
		disconnected through the returned [Connection].

		```lua
		signal:Connect(function(event: string)
			print(event, "was fired!")
		end)
		```

		@within Event
	]=]
	function Event:Connect(callback: Callback): Connection
		return signal:Connect(callback)
	end

	--[=[
		An Event that you can subscribe that can be provided to external consumers
		of this signal.

		This allows you to provide a signal that can be subscribed to, but not fired
		from the outside.

		In our module we can do something like this:

		```lua
		local myObject = {}
		myObject.Event = Signal.new().Event

		return myObject
		```

		Then in another script we can do:

		```lua
		myObject.Event:Connect(function(event: string)
			print(event, "was fired!")
		end)
		```

		@readonly

		@prop Event Event
		@within Signal
	]=]
	signal.Event = setmetatable({}, Event)
	signal.listeners = LinkedList.new()

	return signal
end

--[=[
	Connect a [Callback] to this Signal.

	The Callback will be called every time this Signal fires. It can be
	disconnected through the returned [Connection].

	```lua
	signal:Connect(function(event: string)
		print(event, "was fired!")
	end)
	```
]=]
function Signal:Connect(callback: Callback): Connection
	local entry: LinkedList.Entry<unknown>?

	local listener: Listener = {
		callback = callback,
		connection = {
			disconnect = function()
				if not entry then
					return
				end

				entry.remove()
				entry = nil
			end,

			isConnected = function(): boolean
				return entry ~= nil
			end,
		},
	}

	entry = self.listeners:Push(listener)
	return listener.connection
end

--[=[
	Fires this Signal.

	Any parameters can be provided that will be passed to any listening
	[Callbacks](#Callback).

	```lua
	-- Fire the Signal and pass a string to any listeners
	signal:Fire("Our event")
	```
]=]
function Signal:Fire(...: unknown)
	for listener in self.listeners do
		task.spawn(listener.callback, ...)
	end
end

--[=[
	Disconnects every listener from this Signal.
]=]
function Signal:DisconnectAll()
	for listener in self.listeners do
		listener.connection.disconnect()
	end
end

return Signal
