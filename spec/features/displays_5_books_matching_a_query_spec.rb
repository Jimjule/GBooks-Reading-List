# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Displays 5 Boks Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('2', 'Ruby', '0', '3')
    booklist.go
    expect(booklist.go).to include('----- 1', '----- 2', '----- 3', '----- 4', '----- 5')
  end
end
