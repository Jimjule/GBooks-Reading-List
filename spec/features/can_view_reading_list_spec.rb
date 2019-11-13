# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'The user can view their Reading List' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('3')
    booklist.go
    expect($STDOUT).to include
    ("Your Reading List now contains 0 books: ")
  end
end
