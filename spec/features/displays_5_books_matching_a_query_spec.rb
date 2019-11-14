# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    booklist.go
    expect($STDOUT).to include('----- 1')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    booklist.go
    expect($STDOUT).to include('----- 2')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    booklist.go
    expect($STDOUT).to include
    ('----- 3')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    booklist.go
    expect($STDOUT).to include
    ('----- 4')
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    booklist.go
    expect($STDOUT).to include
    ('----- 5')
  end
end
