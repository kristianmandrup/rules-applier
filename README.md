# Rule Applier

[![Greenkeeper badge](https://badges.greenkeeper.io/kristianmandrup/rules-applier.svg)](https://greenkeeper.io/)

Perform rule application both statically and dynamically ;)

## Status

Needs some polishing... Please help out :)

## Rule application

Rule application is always performed in an `ApplyContext`

### Apply Context

All rules are applied in an apply context

`ruleApplyContext = new ApplyContext(rulesRepository)`

```js
ucan: (actions, subjects, ctx) ->
  @debug 'register ucan', actions, subjects, ctx
  @repo.register 'can', actions, subjects, ctx
```

Any rule, when evaluated has the form `@ucan(actions, subjects, ctx)`

```js
rules:
  user:
    admin: (ar) ->
      var author = ar.subject.author;
      if (author.role === 'administrator' &&
          author.email === ar.user.email) {
        @ucan 'read', 'Book'
      }
```

Evaluating a rule, simply means registering it in a repo for that access request.
When all rules have been evaluated, the repo is consulted to determine if the rules
allow or disallow the access request in aggregate. Then we can cache the result for that access request
using a [fingerprint](https://github.com/kristianmandrup/fingerprint).

## Rules applier

The `RulesApplier` is a general purpose rule applier. It is constructed with an execution context and a set
of rules to reference and apply.

`new RulesApplier(@execution-context, @rules)`

```js
  repo: ->
    @execution-context.repo

  apply: (thing, ctx) ->
    @rule-applier(thing, ctx).apply!

  rule-applier: (thing, ctx)->
    new RuleApplier thing, ctx

  # should iterate through rules object recursively and execute any function found
  apply-all: ->
```

`apply-all` is used to apply all rules (recursively) starting from a certain key in a rules object.
This could f.ex be used to apply all rules on a 'static' key (a typical use case for permits).
Also see `StaticApplier`

## Static rule application

Rules that can be applied on application load. Rules that always have the same effect.
Rules which are not dependant on the access request, ie. rule functions which don't take
an `access-request` as an argument.

### Static Applier

The `StaticApplier` is used to apply static rules that always return the same
permission result with no concern for the `access-request`.

```js
staticApplier = new StaticApplier(executionContext, rules)
staticApplier.apply()
```

`StaticApplier` has an `apply-rules` method which by default will apply rules for the `static`
key of the rules container object (ie. rules repo)

```js
apply-rules: (name = 'static') ->
  @apply-rules-for name
  @
```

## Dynamic rule application

### Dynamic Applier

The `DynamicApplier` is used to apply rules dynamically with respect to the incoming access request.

```js
dynamicApplier = new StaticApplier(executionContext, rules, access-request)
dynamicApplier.apply()
```

## Applying a single rule

This functionality is found in the `rule/apply/single` folder

The `RuleApplier` is the main entry point, it takes a rule and applies it.

`ObjectRuleApplier` and `KeyRuleApplier` ?

## TODO

## Contribution

Please help improve this project, suggest improvements, add better tests etc. ;)

## Licence

MIT License
Copyright 2014-2015 Kristian Mandrup

See LICENSE file