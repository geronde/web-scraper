require 'rails_helper'

RSpec.describe Museum, type: :model do
  describe 'create_ny_museums' do
    it 'should create a list of museums' do
      allow(Museum).to receive(:create).and_return(['created'])
      input = [
        {
          categories: 'type',
          city: 'fake-city',
          description: 'fake-description',
          name: 'source',
          state: ' fake-state'
        }
      ]

      @time_now = Time.now

        puts Date.today
        expect(Museum).to receive(:create).with({ categories: 'type',
                                                  city: 'fake-city',
                                                  description: 'fake-description',
                                                  name: 'source',
                                                  state: ' fake-state' }).and_return(['created'])
        Museum.create_ny_museums(input)
    end
  end
end
