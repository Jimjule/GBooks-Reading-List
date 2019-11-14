# frozen_string_literal: true

require 'json'
require 'net/http'
require 'open-uri'
require 'set'

# Searches for books, and saves them to a reading list for viewing
class BookList

  GOOGLE_API_SEARCH_URL = 'https://www.googleapis.com/books/v1/volumes?q='
  JSON_ARRAY_OF_BOOK_INFO = 'volumeInfo'
  MAX_NUMBER_OF_RESULTS = 5

  def initialize
    @reading_list = Set[]
  end

  def go
    view_reading_list
    prompt_search_or_quit
    go
  end

  def prompt_search_or_quit
    @result_to_save_to_reading_list = ''
    puts 'Search a book by title, or press ENTER to quit: '
    query = gets.chomp
    query != '' ? fetch_url(query) : quit
  end

  # Constructs url from user query
  def fetch_url(user_input)
    fetch_json_from_url(GOOGLE_API_SEARCH_URL + user_input.to_s)
  end

  # Gets JSON from url
  private
  def fetch_json_from_url(url_of_search)
    puts 'Loading...'
    json_results_of_query = Net::HTTP.get(URI.parse(url_of_search))
    parse_fetched_json(json_results_of_query)
  end

  # Converts JSON to a hash
  private
  def parse_fetched_json(json_from_url)
    hash_of_search_results = JSON.parse(json_from_url)
    check_for_no_results(hash_of_search_results)
  end

  # Returns to the beginning if no matches
  private
  def check_for_no_results(hash_of_results)
    if hash_of_results['totalItems'] == 0
      puts 'No results, try again'
      go
    end
    display_top_five_results(hash_of_results)
  end

  private
  def display_top_five_results(hash_of_results)
    loop_incrementing_index = 0
    while loop_incrementing_index < 5
      puts '----- ' + (loop_incrementing_index + 1).to_s
      displays_title(hash_of_results, loop_incrementing_index)
      displays_authors(hash_of_results, loop_incrementing_index)
      displays_publisher(hash_of_results, loop_incrementing_index)
      loop_incrementing_index += 1
    end
    save_result(hash_of_results)
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
    if hash_of_results['items'][loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher']
      puts 'Publisher: ' + hash_of_results['items'][loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher']
    else
      puts 'Publisher: Unknown'
    end
  end

  private
  def save_result(hash_of_results)
    while @result_to_save_to_reading_list != 0
      view_reading_list
      prompt_save_input
      save_result_logic(hash_of_results)
      save_result(hash_of_results)
    end
  end

  private
  def save_result_logic(hash_of_results)
    if @result_to_save_to_reading_list.positive? && @result_to_save_to_reading_list -1 < MAX_NUMBER_OF_RESULTS
      @reading_list.add(hash_of_results['items'][@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['title'] +
        ' | ' + hash_of_results['items'][@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['authors'].join(', ') +
        ' | ' + hash_of_results['items'][@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['publisher'])
    end
  end

  def prompt_save_input
    puts 'Save with 1-5, press ENTER to return'
    @result_to_save_to_reading_list = gets.chomp.to_i
  end

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
