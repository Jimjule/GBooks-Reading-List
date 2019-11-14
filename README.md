# GBooks-Reading-List

# Install

- Clone repository from git
- Navigate to GBooks-Reading-List in console
- Run `bundle`

# Run

- Navigate to GBooks-Reading-List in console
- Run `ruby app.rb`

# Testing

- Feature tested by running app manually

- For automated tests:
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

- The book search is performed by querying the googleapis site
- The data is fetched with 'net/http'
- The results are parsed with 'json'

- Started by hard-coding the url to be sent to the API, and parsing the result, and then replaced search parameters

# Current

- Can view Reading List
- Can search for books by title by typing in a query
- Displays a list of 5 books matching that query
- Each item on the list includes the author, title, and publishing company of the book
- Can save books to Reading List
- Will not save duplicates

# Future

- Break BookList into smaller classes
- Search by author, publisher, or other
- Limit returned data to 5 books

# Known Bugs

- Tests do not run together, must be individually run
- Will only save books from the first search each time the program is run

# This Version

- Design (List steps, consider input and output for each, should they share state?)
- Refactor according to chart_plan.jpg
  - Remove superfluous code
  - Remove unnecessary saving of top 5 results
  - Rename methods
  - Split methods per SRP
  - Reduce shared state

# To Be Implemented

- SRP methods
- Further contain state
