# Demo of pre-gem utility `Query`

Will be subsumed into [Pgsnap](https://github.com/dlcmh/pgsnap-ruby) eventually.

## Setup

1. `git clone https://github.com/dlcmh/transactions`
2. `cd transactions`
3. `yarn`
4. `bundle`
5. `rails db:create`
6. `./db_restore`

## Motivations

- difficult to make use of PostgreSQL's more advanced features
- wanted the ability to compose simple queries into a complex one (initially used `scenic` gem to create DB views via migrations, but encountered a big limitation - views need to be dropped in a cascading fashion whenever a definition needs to be changed, and then recreated)
- CTEs (common table expressions) can introduce a [negative performance impact](https://medium.com/@hakibenita/be-careful-with-cte-in-postgresql-fca5e24d2119), especially if they're deeply nested
- queries should be able to be easily prototyped in the console
- keep models & controllers as slim as they were on Day 1

## See the examples

Go to http://localhost:3000 and take it from there.
