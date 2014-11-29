require '../../test_setup'

applier     = require '../../../index'
ApplyMixin  = applier.rule.ApplyMixin

fixtures = require '../../fixtures'
User     = fixtures.user
Book     = fixtures.book

expect = require 'chai' .expect

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
