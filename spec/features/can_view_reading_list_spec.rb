# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'The user can view their Reading List' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('')
    expect { booklist.go }.to output
    'Your Reading List now contains 0 books: '.to_stdout
  end
end
