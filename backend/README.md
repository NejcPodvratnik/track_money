# Backend

## How to run
```
npm install
npm run dev
```

## Endpoints

**POST** api/signup
- Body must contain: email, name, surname, password 

Used for creating a user.
Returns user info and authorization token.
Returns an error if body is invalid.

**POST** api/authenticate
- Body must contain: email, password 

Used for authenticating an existing user.
Returns user info and authorization token.
Returns an error if body is invalid.
Return an error if a user with the same email and password is not found.

**GET** api/user/:id

Used for getting user info from user that has given id.
Returns user info. 
Returns an error if user is not found.

**POST** api/transaction
- Body must contain: value (must be in a valid currency format), paymentMethod, flow (either inflow or ouflow), category, description
- Headers must contain: Authorization (in format "Bearer [token]")

Used for creating a transaction.
Returns the created transaction.
Returns an error if the authentication or body is invalid.

**POST** api/transaction/list
- Body must contain: startDate, endDate, flow (either inflow or ouflow)
- Headers must contain: Authorization (in format "Bearer [token]")

Used for getting all transactions that match the given filter from a specific user.
Returns a list of transactions.
Returns an error if the authentication or body is invalid.

**GET** api/transaction/:transaction
- Headers must contain: Authorization (in format "Bearer [token]")

Used for getting a specific transaction that belongs to the authorized user.
Returns the transaction.
Returns an error if the authentication is invalid.
Returns an error if the transaction does not belong to the user.

**PUT** api/transaction/:transaction
- Body must contain: value (must be in a valid currency format), paymentMethod, flow (either inflow or ouflow), category, description
- Headers must contain: Authorization (in format "Bearer [token]")

Used for updating a transaction.
Returns the updated transaction.
Returns an error if the authentication or body is invalid.
Returns an error if the transaction does not belong to the user.

**DELETE** api/transaction/:transaction
- Headers must contain: Authorization (in format "Bearer [token]")

Used for removing a transaction.
Returns a message.
Returns an error if the authentication is invalid.
Returns an error if the transaction does not belong to the user.






