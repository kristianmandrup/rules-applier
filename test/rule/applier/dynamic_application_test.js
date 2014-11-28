// Generated by LiveScript 1.2.0
(function(){
  var rule, fixtures, User, Book;
  require('../../test_setup');
  rule = require('../../../index');
  fixtures = require('../../fixtures');
  User = fixtures.user;
  Book = fixtures.book;
  describe('Dynamic rule application on Rule container', function(){
    var book, applier, requests, permits, users;
    requests = {
      admin: {},
      kris: {}
    };
    permits = {};
    users = {};
    return before(function(){
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
      requests.kris.readPaper = {
        user: users.kris,
        action: 'read',
        subject: 'paper',
        ctx: {
          area: 'visitor'
        }
      };
      describe('dynamic rules application - user rules', function(){
        beforeEach(function(){
          var applier;
          Permit.registry.clean();
          permits.guest = createPermit.admin();
          applier = permits.guest.applier(requests.kris.readPaper);
          return applier.applyUserRules(users.kris);
        });
        return specify('registers a manage User rule', function(){
          return permits.guest.canRules()['manage'].should.include('User');
        });
      });
      describe('dynamic rules application - action rules', function(){
        beforeEach(function(){
          Permit.registry.clean();
          permits.guest = createPermit.guest();
          applier = permits.guest.applier(requests.admin.readBook);
          return applier.applyActionRules('read');
        });
        return specify('registers a read Book rule', function(){
          return permits.guest.canRules()['read'].should.include('Book');
        });
      });
      describe('dynamic rules application - ctx rules', function(){
        beforeEach(function(){
          Permit.registry.clean();
          permits.guest = createPermit.guest();
          applier = permits.guest.applier(requests.admin.readBook);
          return applier.applyContextRules({
            area: 'visitor'
          });
        });
        return specify('registers a publish Paper rule', function(){
          return permits.guest.canRules()['publish'].should.include('Paper');
        });
      });
      describe('dynamic rules application - subject rules - class', function(){
        beforeEach(function(){
          permits = {};
          Permit.registry.clean();
          permits.admin = createPermit.admin();
          applier = permits.admin.applier(requests.kris.readPaper);
          return applier.applySubjectRules('Paper');
        });
        return specify('registers an approve Paper rule', function(){
          return permits.admin.canRules()['approve'].should.include('Paper');
        });
      });
      describe('dynamic rules application - subject rules - instance to class', function(){
        beforeEach(function(){
          var Paper, paper;
          Paper = (function(){
            Paper.displayName = 'Paper';
            var prototype = Paper.prototype, constructor = Paper;
            function Paper(name){
              this.name = name;
            }
            return Paper;
          }());
          paper = new Paper({
            title: 'a paper'
          });
          permits = {};
          Permit.registry.clean();
          permits.admin = createPermit.admin();
          applier = permits.admin.applier(requests.kris.readPaper);
          return applier.applySubjectRules(paper);
        });
        return specify('registers an approve Paper rule', function(){
          return permits.admin.canRules()['approve'].should.include('Paper');
        });
      });
      return describe('dynamic rules application', function(){
        beforeEach(function(){
          Permit.registry.clean();
          permits.guest = createPermit.guest();
          return permits.guest.applyRules(requests.admin.readBook, 'force');
        });
        specify('registers a read-book rule', function(){
          return permits.guest.canRules()['read'].should.include('Book');
        });
        specify('does NOT register a write-book rule', function(){
          return function(){
            return permits.guest.canRules()['write'].should;
          }.should['throw'];
        });
        return context('dynamic rules applied twice', function(){
          return beforeEach(function(){
            Permit.registry.clean();
            permits.guest = createPermit.guest();
            permits.guest.applyRules(requests.admin.readBook);
            permits.guest.applyRules(requests.admin.readBook);
            permits.guest.applyRules(requests.admin.readBook);
            return specify('still registers only a SINGLE read-book rule', function(){
              return permits.guest.canRules()['read'].should.eql(['Book']);
            });
          });
        });
      });
    });
  });
}).call(this);
