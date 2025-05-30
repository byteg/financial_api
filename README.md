# README

* NOTICE: master.key was intentionally added to the repository for JWT authentication to work.

* Installation:
  * Install ruby 3.4.4 if it's not installed:
  ```
  rvm install 3.4.4
  or
  rbenv install 3.4.4
  ```
  * Install dependencies and prepare database:
  ```
  bundle
  rails db:create
  rails db:migrate
  ```
  * Start server:
  ```
  ./bin/rails s
  ```

* User registration:
  ```
  curl -v http://localhost:3000/api/users.json \
  -H "Content-Type: application/json" \
  -d '{"user": {"email": "user1@example.com"}}'
  ```
  In return there will be a header
  ```
  authorization: Bearer <JWT token>
  ```
* Balance request:
  ```
  curl -v http://localhost:3000/api/balance.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>"
  ```
* Balance deposit:
  ```
  curl -v http://localhost:3000/api/balance/deposit.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>" \
  -d '{"amount_cents": 100}'
  ```

* Balance withdraw:
  ```
  curl -v http://localhost:3000/api/balance/withdraw.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>" \
  -d '{"amount_cents": 100}'
  ```
* Balance transfer:
  ```
  curl -v http://localhost:3000/api/balance/transfer.json \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <JWT token>" \
  -d '{"amount_cents": 100, "user_id": 2}'
  ```

* Testing
  * Prepare databse:
  ```
  RAILS_ENV=test rails db:migrate
  ```
  * Run tests:
  ```
  rspec
  ```