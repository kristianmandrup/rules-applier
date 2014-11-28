require '../../../test_setup'

rule        = require '../../../../index'
ApplyMixin  = rule.apply.single.ApplyMixin

fixtures = require '../../../fixtures'
User     = fixtures.user
Book     = fixtures.book

class Invalid implements ApplyMixin
  ->
    # nothing

class Rules implements ApplyMixin
  (@rules = {}) ->

describe 'ApplyMixin' ->
  var mixer

  context 'no @rules' ->
    before ->
      mixer := new Invalid

    specify 'throws' ->
      expect mixer.context-rules 'user' .to.throw

  context 'has @rules' ->
    before ->
      mixer := new Rules

    specify 'ok' ->
      expect mixer.context-rules 'user' .to.not.throw

    describe 'context-rules' ->
