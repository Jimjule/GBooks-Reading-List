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
    @menu_choice = 0
    @result_to_save_to_reading_list = -1
  end

  def enter_menu_choice
    @menu_choice = gets.chomp.to_i
  end

  def display_menu_choices
    puts '1. View Reading List'
    puts '2. Search for Books'
    puts '3. Exit'
    puts 'Select an option by typing a number: '
  end

  def go
    while @menu_choice < 1 || @menu_choice > 3
      puts '~~~'
      display_menu_choices
      enter_menu_choice
      menu
    end
  end

  def menu
    case @menu_choice
    when 1
      case_one
    when 2
      case_two
    when 3
      puts 'Goodbye!'
      exit
    end
  end

  def case_one
    @menu_choice = 0
    view_reading_list
    go
  end

  def case_two
    @menu_choice = 0
    fetch_url
    json(@book_search_url)
    check_for_no_results
    top_results
    result_data
    save_result
    go
  end

  # Constructs url from user query
  def fetch_url
    puts 'Search a book by title: '
    query = gets.chomp
    @book_search_url = GOOGLE_API_SEARCH_URL + query.to_s
  end

  # Gets JSON from url, and converts to a hash
  def json(url_of_search)
    puts 'Loading...'
    json_results_of_query = Net::HTTP.get(URI.parse(url_of_search))
    @hash = JSON.parse(json_results_of_query)
  end

  # Returns to the beginning if no matches
  def check_for_no_results
    if @hash['totalItems'] == 0
      puts 'No results, try again'
      go
    end
  end

  # Saves top five results
  def top_results
    loop_incrementing_index = 0
    @top_five_results = []
    until loop_incrementing_index == 5
      @top_five_results.push(@hash['items'][loop_incrementing_index])
      loop_incrementing_index += 1
    end
  end

  # Displays title, author, etc. of top results
  def result_data
    loop_incrementing_index = 0
    while loop_incrementing_index < @top_five_results.length
      display_top_five_results(loop_incrementing_index)
      loop_incrementing_index += 1
    end
  end

  def display_top_five_results(loop_incrementing_index)
    puts '----- ' + (loop_incrementing_index + 1).to_s
    puts 'Title: ' + @top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['title']
    puts 'Author(s): ' + @top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['authors'].join(', ')
    if @top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher']
      puts 'Publisher: ' + @top_five_results[loop_incrementing_index][JSON_ARRAY_OF_BOOK_INFO]['publisher']
    else
      puts 'Publisher: Unknown'
    end
  end

  def save_result
    while @result_to_save_to_reading_list != 0
      view_reading_list
      save_result_logic
      save_result
    end
    menu
  end

  def save_result_logic
    puts 'Save with 1-5, return with 0'
    @result_to_save_to_reading_list = gets.chomp.to_i
    if @result_to_save_to_reading_list.positive? && @result_to_save_to_reading_list < @top_five_results.length + 1
      @reading_list.add(@top_five_results[@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['title'] +
        ' | ' + @top_five_results[@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['authors'].join(', ') +
        ' | ' + @top_five_results[@result_to_save_to_reading_list - 1][JSON_ARRAY_OF_BOOK_INFO]['publisher'])
    end
  end

  def view_reading_list
    puts "Your Reading List now contains #{@reading_list.length} books: "
    @reading_list.each do |book|
      puts book
    end
  end
end
