require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test 'should have a title value' do 
    photo = Photo.new(image_url:'some.jpg')
    assert_not photo.save
  end

  test 'should have an image_url value' do 
    photo = Photo.new(title:'some.jpg')
    assert_not photo.save
  end

  test 'should not save non valid image urls' do
    photo = Photo.new(title:'some', image_url:'some')
    assert_not photo.save
  end

  test 'should save valida image urls' do 
    photo = Photo.new(image_url:'some.jpg', title: 'some')
    assert photo.save
  end
end

