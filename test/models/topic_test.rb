require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @topic = Topic.new(title: 'Example')
  end

  test 'should be valid' do
    assert @topic.valid?
  end

  test 'content can not be blank' do
    @topic.title = ' '
    assert_not @topic.valid?
  end

  test 'content should be unique' do
    duplicate_topic = @topic.dup
    @topic.save
    assert_not duplicate_topic.valid?
  end

  test "title should not be too long" do
    @topic.title = "a" * 256
    assert_not @topic.valid?
  end
end
