local Signal = require(script.Parent)

return function()
	describe("Signal", function()
		describe("new", function()
			it("should return a Signal", function()
				local signal = Signal.new()

				expect(signal).to.be.ok()
				expect(signal).to.be.a("table")
			end)
		end)

		describe("Connect", function()
			local signal

			beforeEach(function()
				signal = Signal.new()
			end)

			afterEach(function()
				signal:DisconnectAll()
			end)

			it("should return a Connection", function()
				local connection = signal:Connect(function() end)

				expect(connection).to.be.ok()
				expect(connection).to.be.a("table")
			end)

			it("should add a listener", function()
				local called = false

				signal:Connect(function()
					called = true
				end)

				expect(called).to.equal(false)
				signal:Fire()
				expect(called).to.equal(true)
			end)

			it("should add multiple listeners", function()
				local called1 = false
				local called2 = false

				signal:Connect(function()
					called1 = true
				end)

				signal:Connect(function()
					called2 = true
				end)

				expect(called1).to.equal(false)
				expect(called2).to.equal(false)
				signal:Fire()
				expect(called1).to.equal(true)
				expect(called2).to.equal(true)
			end)
		end)

		describe("Fire", function()
			local signal

			beforeEach(function()
				signal = Signal.new()
			end)

			afterEach(function()
				signal:DisconnectAll()
			end)

			it("should call listeners with an argument", function()
				local receivedArg

				signal:Connect(function(arg)
					receivedArg = arg
				end)

				expect(receivedArg).never.to.be.ok()
				signal:Fire("arg1")
				expect(receivedArg).to.equal("arg1")
			end)

			it("should call listeners with multiple arguments", function()
				local receivedArgs

				signal:Connect(function(...)
					receivedArgs = { ... }
				end)

				expect(receivedArgs).never.to.be.ok()
				signal:Fire("arg1", "arg2", "arg3")
				expect(receivedArgs).to.be.ok()
				expect(#receivedArgs).to.equal(3)
				expect(receivedArgs[1]).to.equal("arg1")
				expect(receivedArgs[2]).to.equal("arg2")
				expect(receivedArgs[3]).to.equal("arg3")
			end)
		end)

		describe("DisconnectAll", function()
			local signal

			beforeEach(function()
				signal = Signal.new()
			end)

			afterEach(function()
				signal:DisconnectAll()
			end)

			it("should disconnect all listeners", function()
				local called1 = false
				local called2 = false

				signal:Connect(function()
					called1 = true
				end)

				signal:Connect(function()
					called2 = true
				end)

				expect(called1).to.equal(false)
				expect(called2).to.equal(false)
				signal:Fire()
				expect(called1).to.equal(true)
				expect(called2).to.equal(true)

				signal:DisconnectAll()

				called1 = false
				called2 = false

				signal:Fire()
				expect(called1).to.equal(false)
				expect(called2).to.equal(false)
			end)
		end)
	end)

	describe("Connection", function()
		local signal

		beforeEach(function()
			signal = Signal.new()
		end)

		afterEach(function()
			signal:DisconnectAll()
		end)

		describe("disconnect", function()
			it("should disconnect the listener", function()
				local called = false

				local connection = signal:Connect(function()
					called = true
				end)

				expect(called).to.equal(false)
				signal:Fire()
				expect(called).to.equal(true)

				called = false
				connection.disconnect()
				signal:Fire()
				expect(called).to.equal(false)
			end)

			it("should disconnect the listener when called multiple times", function()
				local called = false

				local connection = signal:Connect(function()
					called = true
				end)

				expect(called).to.equal(false)
				signal:Fire()
				expect(called).to.equal(true)

				called = false
				connection.disconnect()
				connection.disconnect()
				connection.disconnect()
				signal:Fire()
				expect(called).to.equal(false)
			end)
		end)

		describe("isConnected", function()
			it("should return true if the listener is connected", function()
				local connection = signal:Connect(function() end)

				expect(connection.isConnected()).to.equal(true)
			end)

			it("should return false if the listener is disconnected", function()
				local signal = Signal.new()
				local connection = signal:Connect(function() end)

				connection.disconnect()
				expect(connection.isConnected()).to.equal(false)
			end)
		end)
	end)

	describe("Event", function()
		local signal
		local event

		beforeEach(function()
			signal = Signal.new()
			event = signal.Event
		end)

		afterEach(function()
			signal:DisconnectAll()
		end)

		describe("Connect", function()
			it("should return a Connection", function()
				local connection = event:Connect(function() end)

				expect(connection).to.be.ok()
				expect(connection).to.be.a("table")
			end)

			it("should add a listener", function()
				local called = false

				event:Connect(function()
					called = true
				end)

				expect(called).to.equal(false)
				signal:Fire()
				expect(called).to.equal(true)
			end)

			it("should add multiple listeners", function()
				local called1 = false
				local called2 = false

				event:Connect(function()
					called1 = true
				end)

				event:Connect(function()
					called2 = true
				end)

				expect(called1).to.equal(false)
				expect(called2).to.equal(false)
				signal:Fire()
				expect(called1).to.equal(true)
				expect(called2).to.equal(true)
			end)
		end)
	end)
end
