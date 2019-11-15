# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Displays information about each book' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '0', '')
    expect { booklist.go }.to output
    'Title:'.to_stdout
  end
  it 'Displays information about each book' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '0', '')
    expect { booklist.go }.to output
    'Author(s)'.to_stdout
  end
  it 'Displays information about each book' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '0', '')
    expect { booklist.go }.to output
    'Publisher'.to_stdout
  end
end
