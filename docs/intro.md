---
sidebar_position: 1
---

# Getting Started

This is a straightforward signal implementation in Luau for _Roblox_.

This guide will help you get started with this signal by walking you through the
process of installing it and using it in your projects.

## Installation

To use this signal, you need to include it as a dependency in your `wally.toml`
file. It can then be installed with [Wally].

```toml
Signal = "lasttalon/signal@0.1.0"
```

[wally]: https://wally.run

## Usage

To create a signal in your project, simply require the module and use the `new`
constructor. We can then manipulate the signal using the provided methods.

```lua
local Signal = require(ReplicatedStorage.Packages.Signal)

-- Create a new signal
local signal = Signal.new()

-- Connect a function to the signal
signal:Connect(function()
  print("Signal fired!")
end)

-- Fire the signal
signal:Fire()
```

Refer to the [API documentation][api] for more detailed information.

[api]: ../api/
