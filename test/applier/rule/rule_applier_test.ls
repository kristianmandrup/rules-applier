require '../../test_setup'

applier           = require '../../../index'
RuleApplier       = applier.rule.RuleApplier
ApplyContext      = applier.ApplyContext

fixtures = require '../../fixtures'
User     = fixtures.user
Book     = fixtures.book

expect = require 'chai' .expect

create-applier = (rules, name, context, debug = true) ->
  new RuleApplier rules, name, context, debug

describe 'RuleApplier' ->
  var applier, ctx, object

  context 'invalid' ->
    specify 'throws' ->
      expect create-applier {}, void .to.throw

