# frozen_string_literal: true

require 'json'
require 'net/http'
require 'open-uri'
require 'set'

# Searches for books, and saves them to a reading list
class BookList

  GOOGLE_API_SEARCH_URL = 'https://www.googleapis.com/books/v1/volumes?q='
  JSON_ARRAY_OF_BOOK_INFO = 'volumeInfo'

  def initialize
    @reading_list = Set[]
    @result_to_save_to_reading_list = -1
  end

  def go
    view_reading_list
    prompt_search_or_quit
    # check_for_no_results
    # top_results
    # result_data
    # save_result
    go
  end

  def prompt_search_or_quit
    puts 'Search a book by title, or press ENTER to quit: '
    query = gets.chomp
    query != '' ? fetch_url(query) : quit
  end

  # Constructs url from user query
  def fetch_url(user_input)
    fetch_json_from_url(GOOGLE_API_SEARCH_URL + user_input.to_s)
  end

  # Gets JSON from url, and converts to a hash
  def fetch_json_from_url(url_of_search)
    puts 'Loading...'
    json_results_of_query = Net::HTTP.get(URI.parse(url_of_search))
    parse_fetched_json(json_results_of_query)
  end

  def parse_fetched_json(json_from_url)
    hash_of_search_results = JSON.parse(json_from_url)
    check_for_no_results(hash_of_search_results)
  end

  # Returns to the beginning if no matches
  def check_for_no_results(hash_of_results)
    if hash_of_results['totalItems'] == 0
      puts 'No results, try again'
      go
    end
    top_results(hash_of_results)
  end

  # Saves top five results
  def top_results(hash_of_results)
    loop_incrementing_index = 0
    top_five_results = []
    until loop_incrementing_index == 5
      top_five_results.push(hash_of_results['items'][loop_incrementing_index])
      loop_incrementing_index += 1
    end
    display_top_five_results(top_five_results)
  end

  # # Displays title, author, etc. of top results
  # def result_data(top_five_results)
  #   loop_incrementing_index = 0
  #   while loop_incrementing_index < top_five_results.length
  #     display_top_five_results(loop_incrementing_index)
  #     loop_incrementing_index += 1
  #   end
  # end

  def display_top_five_results(top_five_results)
    loop_incrementing_index = 0
    while loop_incrementing_index < 5
      puts '----- ' + (loop_incrementing_index + 1).to_s
      puts 'Title: ' + top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['title']
      puts 'Author(s): ' + top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['authors'].join(', ')
      if top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher']
        puts 'Publisher: ' + top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher']
      else
        puts 'Publisher: Unknown'
      end
      loop_incrementing_index += 1
    end
    save_result(top_five_results)
  end

  def save_result(top_five_results)
    while @result_to_save_to_reading_list != 0
      view_reading_list
      save_result_logic(top_five_results)
      save_result(top_five_results)
    end
  end

  def save_result_logic(top_five_results)
    puts 'Save with 1-5, return with 0'
    @result_to_save_to_reading_list = gets.chomp.to_i
    if @result_to_save_to_reading_list.positive? && @result_to_save_to_reading_list < top_five_results.length + 1
      @reading_list.add(top_five_results[@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['title'] +
        ' | ' + top_five_results[@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['authors'].join(', ') +
        ' | ' + top_five_results[@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['publisher'])
    end
  end

  def view_reading_list
    puts "Your Reading List now contains #{@reading_list.length} books: "
    @reading_list.each do |book|
      puts book
    end
  end

  def quit
    puts 'Goodbye'
    exit
  end
end
