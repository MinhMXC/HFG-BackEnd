# TECHNICAL DOCUMENTATION

## Database (PostgreSQL)

Please visit ```./db/schema.rb``` to see the schema of the database

## Standard Response

```{ status: "success", data: [data_here]" }``` if success

```{ status: "success", errors: [errors_here]" }``` if error

## Routes

Please visit ```./config/routes.rb``` to see where all routes and corresponding actions are mounted

```resources``` means a model index, create, update, destroy actions are mount at ```GET resource_name/:id```,
```POST resource_name/create```, ```PUT resource_name/:id```, ```DELETE resource_name/:id``` respectively

## Features

### Access Level: 
- A: Admin only
- B: User who own the data
- C: All logged in users
- D: Everyone can access

### User
- All [devise-token-auth](https://github.com/lynndylanhurley/devise_token_auth) features (B)
- Index / View All (A)
- Show User of ID (B)
- Show Current User (D)
- Update (B)
- Mark (any user) As Administrator (A)

### Activity
- Index / View All (D)
- Show Activity of ID (D)
- Create (A)
- Update (A)
- Destroy (A)

### Application
- Index / View All (A)
- View all of a specific user (A + B)
- View all of a specific activity (A)
- Create (C)
- Delete (C)

### Attendance
- View all of a specific user (A + B)
- View all of a specific activity (A)
- Create (A)
- Delete (A)
- Mark (A)
- Unmark (A)
- Delete (A)