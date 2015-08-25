# Blog App

Ruby on Rails Blog Application, using RSpec 3 and Capybara for testing.



## Models

#### Article

| Name     | Type    |
|----------|---------|
| ID       | Integer |
| Title    | String  |
| Body     | Text    |

#### User

| Name     | Type    |
|----------|---------|
| ID       | Integer |
| Email    | String  |
| Password | String  |

#### Comment

| Name         | Type       |
|--------------|------------|
| ID           | Integer    |
| Body         | Text       |
| User_ID      | Integer    |
| Article_ID   | Integer    |
