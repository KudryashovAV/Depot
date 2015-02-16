require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new(title: 'Qweqwe',
                          description: 'asdfg',
                          image_url: 'qqq.gif')
    product.price = -1
    assert product.invalid?
    assert_equal 'must be greater than or equal to 0.01',
                 product.errors[:price].join('; ')
    product.price = 0
    assert_equal 'must be greater than or equal to 0.01',
                 product.errors[:price].join('; ')
    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: 'Sdddd',
                description: 'sadasdasd',
                price: 1,
                image_url: image_url)
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/z/fred.gif}
    bad = %w{fred.gf fred.jg fred.pg FRED.JPG/more
            http://asd.asd.asd/x/d/f/s/fred.Jpg.more}
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert !new_product(name).valid?, "#{name} shouldn't be valid"
    end
  end
end
