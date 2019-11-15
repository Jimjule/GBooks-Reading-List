# frozen_string_literal: true

require 'json'
require 'net/http'
require 'open-uri'
require 'set'

# Searches for books, and saves them to a reading list for viewing
class BookList

  GOOGLE_API_SEARCH_URL = 'https://www.googleapis.com/books/v1/volumes?q='
  JSON_ARRAY_OF_BOOK_INFO = 'volumeInfo'
  JSON_NUMBER_OF_RESULTS = 'totalItems'
  MAX_NUMBER_OF_RESULTS = 5
  LINE_BREAK = '----- '
  SEPARATOR = ' | '

  def initialize
    @reading_list = Set[]
  end

  # Calls the methods
  def go
    view_reading_list
    user_choice = prompt_search_or_quit
    does_user_quit(user_choice)
    json_from_url = search_get_url(user_choice)
    hash_of_search_results = parse_fetched_json(json_from_url)
    check_for_no_results(hash_of_search_results)
    display_top_five_results(hash_of_search_results)
    save_to_reading_list(hash_of_search_results)
    go
  end

  # User chooses to search or quit

  private

  def prompt_search_or_quit
    puts 'Search a book by title, or press ENTER to quit: '
    query = gets.chomp
  end

  # Quits if user chose to

  private

  def does_user_quit(user_input)
    quit if user_input == ''
  end

  # Constructs url from user query

  private

  def search_get_url(user_input)
    fetch_json_from_url(GOOGLE_API_SEARCH_URL + user_input.to_s)
  end

  # Gets JSON from url

  private

  def fetch_json_from_url(url_of_search)
    Net::HTTP.get(URI.parse(url_of_search))
  end

  # Converts JSON to a hash

  private

  def parse_fetched_json(json_from_url)
    JSON.parse(json_from_url)
  end

  # Returns to the beginning if no matches

  private

  def check_for_no_results(hash_of_results)
    if hash_of_results[JSON_NUMBER_OF_RESULTS] == 0
      puts 'No results, try again'
      go
    end
  end

  private

  def display_top_five_results(hash_of_results)
    loop_incrementing_index = 0
    while loop_incrementing_index < 5
      puts LINE_BREAK + (loop_incrementing_index + 1).to_s
      displays_title(hash_of_results, loop_incrementing_index)
      displays_authors(hash_of_results, loop_incrementing_index)
      displays_publisher(hash_of_results, loop_incrementing_index)
      loop_incrementing_index += 1
    end
  end

  private

  def displays_title(hash_of_results, loop_incrementing_index)
    puts 'Title: ' + hash_of_results['items'][loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['title']
  end

  private

  def displays_authors(hash_of_results, loop_incrementing_index)
    puts 'Author(s): ' + hash_of_results['items'][loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['authors'].join(', ')
  end

  private

  def displays_publisher(hash_of_results, loop_incrementing_index)
    hash_of_results['items'][loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher'] ?
      "Publisher: #{hash_of_results['items'][loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher']}" :
      'Publisher: Unknown'
  end

  private

  # Handles all methods related to saving
  def save_to_reading_list(hash_of_results)
    puts 'Save with 1-5, press ENTER to return'
    while (result_to_save_to_reading_list = gets.chomp.to_i) != 0
      view_reading_list
      save_chosen_result(hash_of_results, result_to_save_to_reading_list)
      save_to_reading_list(hash_of_results)
    end
  end

  private

  def save_chosen_result(hash_of_results, result_to_save_to_reading_list)
    if result_to_save_to_reading_list.positive? && result_to_save_to_reading_list - 1 < MAX_NUMBER_OF_RESULTS
        @reading_list.add(hash_of_results['items'][result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['title'] +
          SEPARATOR + hash_of_results['items'][result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['authors'].join(', ') +
          SEPARATOR + hash_of_results['items'][result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['publisher'])
    end
    reset_save_choice
  end

  private

  def reset_save_choice
    result_to_save_to_reading_list = ''
  end

  private

  def view_reading_list
    puts "Your Reading List now contains #{@reading_list.length} books: "
    @reading_list.each do |book|
      puts book
    end
  end

  private

  def quit
    puts 'Goodbye'
    exit
  end
end
