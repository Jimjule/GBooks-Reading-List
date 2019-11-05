# frozen_string_literal: true

require 'glist'

describe BookList do
  it "Menu doesn't crash with bad input" do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('zzz', 'uhhh', 'oops', '3')
    booklist.go
  end
end
