# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TargetingService do
  describe TargetingService::TargeterResolver do
    context 'when target type is male' do
      let(:target) { FactoryBot.build(:target, type: :male) }

      it 'return male targeter' do
        targeter = TargetingService::TargeterResolver.resolve(target)
        expect(targeter).to eq TargetingService::Targeter::MaleTargeter
      end
    end
  end
  describe TargetingService::Targeter do
    describe TargetingService::Targeter::MaleTargeter do
      let!(:male_users) { FactoryBot.create_list(:user, 2, gender: :male) }
      let!(:female_user) { FactoryBot.create(:user, gender: :female) }
      let!(:other_gender_user) { FactoryBot.create(:user, gender: :other) }
      let!(:unknown_gender_user) { FactoryBot.create(:user, gender: nil) }

      it 'users male only' do
        users = TargetingService::Targeter::MaleTargeter.new.call
        expect(users).to eq male_users
      end

      it 'users not include female user' do
        users = TargetingService::Targeter::MaleTargeter.new.call
        expect(users).to_not be_include(female_user)
      end

      it 'users not include other gender user' do
        users = TargetingService::Targeter::MaleTargeter.new.call
        expect(users).to_not be_include(other_gender_user)
      end

      it 'users not include unknown gender user' do
        users = TargetingService::Targeter::MaleTargeter.new.call
        expect(users).to_not be_include(unknown_gender_user)
      end
    end
  end
end
