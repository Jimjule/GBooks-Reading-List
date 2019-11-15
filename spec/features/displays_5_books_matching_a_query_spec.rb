# frozen_string_literal: true

require 'glist'

describe BookList do
  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    expect { booklist.go }.to output
    '----- 1'.to_stdout
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    expect { booklist.go }.to output
    '----- 2'.to_stdout
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    expect { booklist.go }.to output
    '----- 3'.to_stdout
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    expect { booklist.go }.to output
    '----- 4'.to_stdout
  end

  it 'Displays 5 Books Matching a Query' do
    booklist = BookList.new
    allow(booklist).to receive(:gets).and_return('Ruby', '')
    expect { booklist.go }.to output
    '----- 5'.to_stdout
  end
end
