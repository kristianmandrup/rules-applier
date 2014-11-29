// Generated by LiveScript 1.2.0
(function(){
  var rule, fixtures, User, Book, expect;
  require('../../../test_setup');
  rule = require('../../../../index');
  fixtures = require('../../../fixtures');
  User = fixtures.user;
  Book = fixtures.book;
  expect = require('chai').expect;
  describe('Rule application on Rule container', function(){
    return describe('RuleContainerApplier', function(){
      var book, applier, requests, permits, users;
      requests = {
        admin: {},
        kris: {}
      };
      permits = {};
      users = {};
      before(function(){
        book = new Book('a book');
        requests.admin.readBook = {
          user: {
            role: 'admin'
          },
          action: 'read',
          subject: book,
          ctx: {
            area: 'visitor'
          }
        };
        users.kris = createUser.kris();
        return requests.kris.readPaper = {
          user: users.kris,
          action: 'read',
          subject: 'paper',
          ctx: {
            area: 'visitor'
          }
        };
      });
      return describe('Rules application', function(){
        return describe('static rules application', function(){
          beforeEach(function(){
            var applier;
            Permit.registry.clean();
            permits.guest = createPermit.guest();
            permits.guest.debugOn();
            applier = permits.guest.applier();
            applier.debugOn();
            permits.guest.init();
            applier.apply('static', true);
            return console.log(permits.guest.repo().canRules());
          });
          return specify('registers a read-any rule (using default)', function(){
            return expect(permits.guest.canRules()['read']).to.eql(['*']);
          });
        });
      });
    });
  });
}).call(this);
