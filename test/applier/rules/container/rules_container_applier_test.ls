require '../../test_setup'

rule      = require '../../../index'

fixtures = require '../../fixtures'
User     = fixtures.user
Book     = fixtures.book

expect = require 'chai' .expect

describe 'Rule application on Rule container' ->
  var book, applier
  requests  =
    admin: {}
    kris:  {}
  permits   = {}
  users     = {}

  before ->
    book := new Book 'a book'
    requests.admin.read-book :=
      user:
        role: 'admin'
      action: 'read'
      subject: book
      ctx:
        area: 'visitor'

    users.kris = create-user.kris!

    requests.kris.read-paper :=
      user: users.kris
      action: 'read'
      subject: 'paper'
      ctx:
        area: 'visitor'

  describe 'Rules application' ->
    # auto applies static rules by default (in init) as part of construction!
    describe 'static rules application' ->
      before-each ->
        Permit.registry.clean!
        permits.guest := create-permit.guest!
        permits.guest.debug-on!
        applier = permits.guest.applier!
        applier.debug-on!
        permits.guest.init!

        applier.apply 'static', true

        console.log permits.guest.repo!.can-rules!

      specify 'registers a read-any rule (using default)' ->
        expect permits.guest.can-rules!['read'] .to.eql ['*']


