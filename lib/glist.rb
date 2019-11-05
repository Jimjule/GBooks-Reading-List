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
    # When option to save comes, 0 to return, 1-5 to save
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
    go
  end

  # Constructs url from user query
  def fetch_url
    puts 'Search a book by title: '
    query = gets.chomp
    @url = 'https://www.googleapis.com/books/v1/volumes?q=' + query.to_s
    puts @url
  end

  # Gets JSON from url, and converts to a hash
  def json(target)
    puts 'Loading...'
    json = Net::HTTP.get(URI.parse(target))
    @hash = JSON.parse(json)
    puts @hash
  end

  def reading_list
    puts 'Your Reading List now contains: '
    @list.each do |book|
      puts book
    end
  end
end
