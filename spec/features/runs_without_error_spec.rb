# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Runs without raising an error' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('3')
    booklist.go
    expect { booklist.go }.not_to raise_error
  end
end
