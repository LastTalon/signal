---
sidebar_position: 1
---

# Getting Started

This is a Luau linked list implementation for _Roblox_.

This guide will help you get started with this linked list by walking you
through the process of installing it and using it in your projects.

## Installation

To use this linked list, you need to include it as a dependency in your
`wally.toml` file. It can then be installed with [Wally].

```toml
LinkedList = "lasttalon/linked-list@0.1.0"
```

[wally]: https://wally.run

## Usage

To create a linked list in your project, simply require the module and use the
new constructor. We can then manipulate the list using the provided methods.

```lua
local LinkedList = require(ReplicatedStorage.Packages.LinkedList)

-- Create a new linked list
local list = LinkedList.new()

-- Add some values to the list
list:Push(1)
list:Push(2)
list:Push(3)

-- Remove the last value from the list
local value = list:Pop()
print(value) -- 3

-- Iterate over the list
for value in list do
    print(value)
end
```

Refer to the [API documentation][api] for more detailed information.

[api]: ../api/
