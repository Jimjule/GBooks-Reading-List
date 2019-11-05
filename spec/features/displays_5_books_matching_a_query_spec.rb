# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Ruby', '0', '3')
    booklist.go
    expect(booklist.go).to include
    ('----- 1')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Ruby', '0', '3')
    booklist.go
    expect(booklist.go).to include
    ('----- 2')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Ruby', '0', '3')
    booklist.go
    expect(booklist.go).to include
    ('----- 3')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Ruby', '0', '3')
    booklist.go
    expect(booklist.go).to include
    ('----- 4')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Ruby', '0', '3')
    booklist.go
    expect(booklist.go).to include
    ('----- 5')
  end
end
