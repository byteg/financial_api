# README

* NOTICE: master.key was intentionally added to the repository for JWT authentication to work.

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
