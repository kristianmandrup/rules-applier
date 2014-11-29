util        = require '../util'


# Execute all rules of a particular name (optionally within specific context, such as area, action or role)
#
# apply-rules-for 'read', 'action' - will execute the rules in... rules.action.read
# apply-rules-for 'read' - will execute the rules in rules.read
#
# rules:
#   action:
#     read: ->
#     ....
#   role:
#     admin: ->
#     guest: ->
#   area:
#     admin: ->
utily             = require '../../util'
subject           = utily.subject
Debugger          = utily.Debugger

RuleApplier       = require '../rule' .RuleApplier
ApplyContext      = require '../apply_context'
inspect           = require 'util' .inspect

# Base class for Dynamic- and StaticRulesApplier
module.exports = class RulesApplier implements Debugger
  (@apply-context, @rules, @debugging) ->
    @_validate!
    @

  _validate: ->
    unless @apply-context.ucan and @apply-context.ucannot
      throw Error "Apply context must have ucan and ucannot methods for applying rules, was: #{inspect @apply-context}"

  repo: ->
    @apply-context.repo

  apply: (thing, ctx) ->
    @rule-applier(thing, ctx).apply!

  rule-applier: (thing, ctx)->
    new RuleApplier thing, ctx

  # should iterate through rules object recursively and execute any function found
  apply-all: ->
    switch typeof @rules
    when 'object'
      rules = @rules
      for key of rules
        util.recurse rules[key], @apply-context
    else
      throw Error "rules must be an Object was: #{typeof @rules}"
