require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new }
  before { subject.save }

  it 'should raise an error without post' do
    expect { subject.like_counter }.to raise_error(NoMethodError)
  end
end
