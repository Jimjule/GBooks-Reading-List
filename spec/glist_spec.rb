# frozen_string_literal: true

require 'glist'

describe BookList do
  it "Responds to 'go'" do
    booklist = BookList.new
    expect(booklist).to respond_to(:go)
  end

  it 'Reading List is a Set' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('3')
    expect(booklist.reading_list).to be_kind_of(Set)
  end
end
