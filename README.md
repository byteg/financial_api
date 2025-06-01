# README

* NOTICE: master.key was intentionally added to the repository for JWT authentication to work.

* Database configuration:
  ```
  CREATE ROLE developer WITH LOGIN PASSWORD '12345678';
  ```
  ```
  ALTER ROLE developer CREATEDB;
  ```

* Installation:
  * Install ruby 3.4.4 if it's not installed:
  ```
  rvm install 3.4.4
  or
  rbenv install 3.4.4
  ```
  * Install dependencies and prepare the database:
  ```
  bundle
  ./bin/rails db:create
  ./bin/rails db:migrate
  ```
  * Start server:
  ```
  ./bin/rails s
  ```

* User registration:
  ```
  curl -v http://localhost:3000/api/v1/users.json \
  -H "Content-Type: application/json" \
  -d '{"user": {"email": "user1@example.com"}}'
  ```
  In return there will be a header
  ```
  authorization: Bearer <JWT token>
  ```
* Balance request:
  ```
  curl -v http://localhost:3000/api/v1/balance.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>"
  ```
* Balance deposit:
  ```
  curl -v http://localhost:3000/api/v1/balance/deposit.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>" \
  -d '{"amount_cents": 100}'
  ```

* Balance withdraw:
  ```
  curl -v http://localhost:3000/api/v1/balance/withdraw.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>" \
  -d '{"amount_cents": 100}'
  ```
* Balance transfer:
  ```
  curl -v http://localhost:3000/api/v1/balance/transfer.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>" \
  -d '{"amount_cents": 100, "email": "user2@example.com"}'
  ```

* Testing
  * Prepare the database:
  ```
  RAILS_ENV=test ./bin/rails db:migrate
  ```
  * Run tests:
  ```
  rspec
  ```