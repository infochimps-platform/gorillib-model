# Gorillib::Model

## WARNING

This has been extracted from the open-source library [gorillib](https://github.com/infochimps-labs/gorillib).
All functionality for `Gorillib::Model` has been retained, but all helper methods now come from `active_support`.
This separation from the old `gorillib` is intentional, as support for that library will no longer continue.
Please use this code only as intended, and make no assumptions about old functionality.

## Usage 

`require 'gorillib/model`

Gorillib has at least one powerful addition to the canon: the `Gorillib::Model` mixin.

Think of it like 'An ORM for JSON'. It's designed for data that spends as much time on the wire as it does in action -- things like API handlers or clients, data processing scripts, wukong jobs.

* lightweight
* serializes to/from JSON, TSV or plain hashes
* type converts when you need it, but doesn't complicate normal accessors
* upward compatible with ActiveModel
