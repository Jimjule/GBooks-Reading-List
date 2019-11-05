# GBooks-Reading-List

# Install

- Clone repository from git
- Navigate to GBooks-Reading-List in console
- Run `bundle`

# Run

- Navigate to GBooks-Reading-List in console
- Run `ruby app.rb`

# Testing

- Navigate to GBooks-Reading-List in console
- Run `rspec`

# Linting

- Linted with Rubocop
- Navigate to GBooks-Reading-List in console
- Run `rubocop`

# Minimum Viable Product

This application should allow you to:

- Type in a query and display a list of 5 books matching that query.
- Each item in the list should include the book's author, title, and publishing company.
- A user should be able to select a book from the five displayed to save to a “Reading List”
- View a “Reading List” with all the books the user has selected from their queries -- this is a local reading list and not tied to Google Books’s account features.

# Approach

- I will use an API to query the Google Books API
- I will parse the JSON, and save the results to the reading list

- Started by hard-coding the url to be sent to the API, and parsing the result

# Current

- Can view Reading List
