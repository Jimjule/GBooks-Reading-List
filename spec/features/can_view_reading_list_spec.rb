# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'The user can view their Reading List' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('3')
    expect(booklist.reading_list).to include('A Book | By a Person | That was Published', 'And a Sequel')
  end
end
