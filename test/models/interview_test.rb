require 'test_helper'

class InterviewTest < ActiveSupport::TestCase
  def setup
    @template = create(:template)
    @interview = create(:interview)
  end

  test 'should be valid' do
    assert @interview.valid?
  end

  test 'firstname can not be blank' do
    @interview.firstname = ' '
    assert_not @interview.valid?
  end

  test 'lastname can not be blank' do
    @interview.lastname = ' '
    assert_not @interview.valid?
  end

  test 'template can not be empty' do
    @interview.template = nil
    assert_not @interview.valid?
  end

  test "firstname should not be too long" do
    @interview.firstname = "a" * 256
    assert @interview.valid?
  end

  test "lastname should not be too long" do
    @interview.lastname = "a" * 256
    assert @interview.valid?
  end
end
