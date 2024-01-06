require './exercises'

# Method to allow all classes to define instance methods dynamically
def Object.redefine_method(method_name, method_proc)
  define_method method_name, method_proc
end

describe 'find_evens' do
  it 'returns all numbers if they are all even' do
    expect(find_evens([2, 4, 6])).to eql([2, 4, 6])
  end

  it 'returns an empty array if passed an empty array' do
    expect(find_evens([])).to eql([])
  end

  it 'removes all odd numbers' do
    expect(find_evens([1])).to eql([])
  end

  it 'removes all odd numbers in mix of numbers' do
    expect(find_evens([1, 2, 3])).to eql([2])
  end

  it 'removes all non numbers' do
    expect(find_evens(['a', true, //])).to eql([])
  end

  it 'removes all floating numbers' do
    expect(find_evens([1.0, 2.0, 4.0])).to eql([])
  end

  it 'removes all non integers and odd numbers from mix' do
    expect(find_evens(['a', 2, 5, 6.0, 4, true])).to eql([2, 4])
  end
end

describe 'product' do
  it 'can find the product of 1, 2, 3' do
    expect(product([1, 2, 3])).to eql(6)
  end

  it 'returns 0 if passed an empty array' do
    expect(product([])).to eql(0)
  end

  it 'returns the number if it is the only element passed in' do
    expect(product([1])).to eql(1)
  end

  it 'can find the product of floats' do
    expect(product([1.0, 2.0, 4.0])).to eql(8.0)
  end

  it 'can find the product of mix of fixnums and floats' do
    expect(product([1.0, 2, 3])).to eql(6.0)
  end

  it 'removes all non numbers' do
    expect(product(['a', true, //])).to eql(0)
  end

  it 'removes all non numbers from mix' do
    expect(product(['a', 2, 5.0, 4, true])).to eql(40.0)
  end
end

describe 'uniq' do
  before(:all) do
    # preserve the Array#uniq and Array#uniq! methods
    @uniq = [].method(:uniq)
    @uniq_bang = [].method(:uniq!)
    # disable the uniq and uniq! methods
    class Array
      def uniq
        raise 'uniq is disabled'
      end

      def uniq!
        raise 'uniq! is disabled'
      end
    end
  end

  after(:all) do
    # re-enable uniq and uniq! methods
    Array.redefine_method(:uniq, @uniq)
    Array.redefine_method(:uniq!, @uniq_bang)
  end

  it 'returns an empty array if passed in an empty array' do
    expect(uniq([])).to eql([])
  end

  it 'returns the same array if there are no duplicates' do
    expect(uniq([1, 2, 3])).to eql([1, 2, 3])
  end

  it 'removes all duplicates' do
    expect(uniq([1, 1, 1])).to eql([1])
  end

  it 'should return the array in the same order' do
    expect(uniq([2, 1, 3])).to eql([2, 1, 3])
  end

  it 'removes subsequent elements' do
    expect(uniq([1, 2, 1])).to eql([1, 2])
  end

  it 'can handle a mix of different types' do
    expect(uniq([1, 2, '1', true, 2, true])).to eql([1, 2, '1', true])
  end
end

describe 'parse_phone_number' do
  let(:correct_format) { '(123) 456-7890' }

  it 'parses numbers with no extraneous characters' do
    expect(parse_phone_number('1234567890')).to eql(correct_format)
  end

  it 'parses numbers with extraneous dashes' do
    expect(parse_phone_number('123-456-7890')).to eql(correct_format)
  end

  it 'parses numbers with extraneous spaces' do
    expect(parse_phone_number('1 2 3 4 5 6 7 8 9 0')).to eql(correct_format)
  end

  it 'parses numbers with both extraneous dashes and spaces' do
    expect(parse_phone_number('1-2 345-6-7 8   90')).to eql(correct_format)
  end
end

describe 'invert' do
  before(:all) do
    # preserve the Hash#invert method
    @invert = {}.method(:invert)
    # disable the invert method
    class Hash
      def invert
        raise 'invert is disabled'
      end
    end
  end

  after(:all) do
    # re-enable the Hash#invert method
    Hash.redefine_method(:invert, @invert)
  end

  it 'returns empty hash if passed in an empty hash' do
    expect(invert({})).to eql({})
  end

  it 'inverts hash without duplicates' do
    expect(invert(1 => 'foo', 2 => 'bar')).to eql('foo' => 1, 'bar' => 2)
  end

  it 'inverts hash with duplicates' do
    expect(invert('foo' => 'bar', 'baz' => 'bar'))
      .to eql('bar' => 'baz')
  end

  it 'inverts hash and maintains order with duplicate values' do
    expect(invert(1 => 'foo', 2 => 'bar', 3 => 'foo'))
      .to eql('foo' => 3, 'bar' => 2)
  end
end

describe 'fetch' do
  it 'returns the value if the key is present' do
    expect(fetch({ foo: 'bar' }, :foo, 'missing')).to eql('bar')
  end

  it 'returns the value if the key is present but no third argument' do
    expect(fetch({ foo: 'bar' }, :foo)).to eql('bar')
  end

  it 'returns \'missing\' if the key and third argument are not present' do
    expect(fetch({}, :foo)).to eql('missing')
  end

  it 'returns the third argument if passed in, but the key is not present' do
    expect(fetch({}, :foo, 'bar')).to eql('bar')
  end
end
