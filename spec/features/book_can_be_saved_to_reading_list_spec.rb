# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Saves book to reading list' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '1', '0', '3', '')
    booklist.go
    expect(@reading_list.length).to eq(2)
  end
end
