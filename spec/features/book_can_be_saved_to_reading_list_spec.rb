# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Saves book to reading list' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Ruby', '1', '0', '3')
    booklist.go
    expect(@reading_list.length).to eq(3)
  end
  it 'Saves multiple books to reading list' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Good Omens', '1', '2', '0', '3')
    booklist.go
    expect(@reading_list.length).to eq(4)
  end
end
