require_relative "../lib/code.rb"

describe "aaa" do
  # it 'raise error' do
  #   expect{raise StandardError}.to raise_error
  # end
  it 'puts "hello"' do
    expect{aaa}.to output("hello\n").to_stdout
  end
end
