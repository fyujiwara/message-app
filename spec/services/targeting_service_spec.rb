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
    context 'when target type is female' do
      let(:target) { FactoryBot.build(:target, type: :female) }

      it 'return female targeter' do
        targeter = TargetingService::TargeterResolver.resolve(target)
        expect(targeter).to eq TargetingService::Targeter::FemaleTargeter
      end
    end
    context 'when target type is teenager' do
      let(:target) { FactoryBot.build(:target, type: :teenager) }

      it 'return teenager targeter' do
        targeter = TargetingService::TargeterResolver.resolve(target)
        expect(targeter).to eq TargetingService::Targeter::TeenagerTargeter
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

    describe TargetingService::Targeter::FemaleTargeter do
      let!(:female_users) { FactoryBot.create_list(:user, 2, gender: :female) }
      let!(:male_user) { FactoryBot.create(:user, gender: :male) }
      let!(:other_gender_user) { FactoryBot.create(:user, gender: :other) }
      let!(:unknown_gender_user) { FactoryBot.create(:user, gender: nil) }

      it 'users female only' do
        users = TargetingService::Targeter::FemaleTargeter.new.call
        expect(users).to eq female_users
      end

      it 'users not include male user' do
        users = TargetingService::Targeter::FemaleTargeter.new.call
        expect(users).to_not be_include(male_user)
      end

      it 'users not include other gender user' do
        users = TargetingService::Targeter::FemaleTargeter.new.call
        expect(users).to_not be_include(other_gender_user)
      end

      it 'users not include unknown gender user' do
        users = TargetingService::Targeter::FemaleTargeter.new.call
        expect(users).to_not be_include(unknown_gender_user)
      end
    end

    describe TargetingService::Targeter::TeenagerTargeter do
      let!(:nine_years_old_user) { FactoryBot.create(:user, birthday: Time.current.beginning_of_day.ago(10.years).since(1.days)) }
      let!(:ten_years_old_user) { FactoryBot.create(:user, birthday: Time.current.beginning_of_day.ago(10.years)) }
      let!(:nineteen_years_old_user) { FactoryBot.create(:user, birthday: Time.current.beginning_of_day.ago(20.years).since(1.days)) }
      let!(:twenty_years_old_user) { FactoryBot.create(:user, birthday: Time.current.beginning_of_day.ago(20.years)) }

      before(:each) do
        expect(nine_years_old_user.age).to eq 9
        expect(ten_years_old_user.age).to eq 10
        expect(nineteen_years_old_user.age).to eq 19
        expect(twenty_years_old_user.age).to eq 20
      end
      it 'users teenager only' do
        users = TargetingService::Targeter::TeenagerTargeter.new.call
        expect(users).to be_include(ten_years_old_user)
        expect(users).to be_include(nineteen_years_old_user)
      end

      it 'users not include nine years old user' do
        users = TargetingService::Targeter::TeenagerTargeter.new.call
        expect(users).to_not be_include(nine_years_old_user)
      end

      it 'users not include twenty years old user' do
        users = TargetingService::Targeter::TeenagerTargeter.new.call
        expect(users).to_not be_include(twenty_years_old_user)
      end
    end
  end
end
