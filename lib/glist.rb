# frozen_string_literal: true

require 'json'
require 'net/http'
require 'open-uri'
require 'set'

# Searches for books, and saves them to a reading list
class BookList
  def initialize
    @list = Set['A Book | By a Person | That was Published', 'And a Sequel']
    @choice = 0
    @save = -1
  end

  def enter_choice
    @choice = gets.chomp.to_i
  end

  def display_choices
    puts '1. View Reading List'
    puts '2. Search for Books'
    puts '3. Exit'
    puts 'Select an option by typing a number: '
  end

  def go
    while @choice < 1 || @choice > 3
      puts '~~~'
      display_choices
      enter_choice
      menu
    end
  end

  def menu
    case @choice
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
    @choice = 0
    reading_list
    go
  end

  def case_two
    @choice = 0
    fetch_url
    json(@url)
    check_valid
    top_results
    result_data
    save_result
    go
  end

  # Constructs url from user query
  def fetch_url
    puts 'Search a book by title: '
    query = gets.chomp
    @url = 'https://www.googleapis.com/books/v1/volumes?q=' + query.to_s
  end

  # Gets JSON from url, and converts to a hash
  def json(target)
    puts 'Loading...'
    json = Net::HTTP.get(URI.parse(target))
    @hash = JSON.parse(json)
  end

  # Returns to the beginning if no matches
  def check_valid
    if @hash['totalItems'] == 0
      puts 'No results, try again'
      go
    end
  end

  # Saves top five results
  def top_results
    i = 0
    @five = []
    until i == 5
      @five.push(@hash['items'][i])
      i += 1
    end
  end

  # Displays title, author, etc. of top results
  def result_data
    i = 0
    while i < @five.length
      puts '----- ' + (i + 1).to_s
      puts 'Title: ' + @five[i]['volumeInfo']['title']
      puts 'Author(s): ' + @five[i]['volumeInfo']['authors'].join(', ')
      if @five[i]['volumeInfo']['publisher']
        puts 'Publisher: ' + @five[i]['volumeInfo']['publisher']
      else
        puts 'Publisher: Unknown'
      end
      i += 1
    end
  end

  def save_result
    while @save != 0
      reading_list
      puts 'Save with 1-5, return with 0'
      @save = gets.chomp.to_i
      if @save.positive? && @save < @five.length + 1
        @list.add(@five[@save - 1]['volumeInfo']['title'] +
          ' | ' + @five[@save - 1]['volumeInfo']['authors'].join(', ') +
          ' | ' + @five[@save - 1]['volumeInfo']['publisher'])
      end
      save_result
    end
    menu
  end

  def reading_list
    puts 'Your Reading List now contains: '
    @list.each do |book|
      puts book
    end
  end
end
