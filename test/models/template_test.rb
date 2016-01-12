require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  def setup
    @template = create(:template)
  end

  test 'should be valid' do
    assert @template.valid?
  end

  test 'name should be present' do
    @template.name = '  '
    assert_not @template.valid?
  end

  test 'name should be unique' do
    duplicate_template = @template.dup
    @template.save
    assert_not duplicate_template.valid?
  end
end
