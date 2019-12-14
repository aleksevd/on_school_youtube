require 'rails_helper'

RSpec.describe Flow, type: :model do
  let(:course) { insert(:course) }

  it { is_expected.to belong_to(:course) }
  it { is_expected.to have_many(:user_courses) }

  it { is_expected.to validate_presence_of(:course) }
  it { is_expected.to validate_presence_of(:starts_at) }
  it { is_expected.to validate_presence_of(:checks_finish_at) }
  it { is_expected.to validate_presence_of(:finishes_at) }
  it { is_expected.to validate_presence_of(:price) }

  context 'validation' do
    describe '#not_crossing_other_flow_period' do
      context 'when flows are in same course' do
        let!(:flow1) { insert(:flow, course: course) }
        let(:flow2) { create(:flow, course: course) }

        it 'should fail if starts_at in other flow period' do
          flow2.starts_at = flow1.finishes_at - 1.hour

          expect(flow2).not_to be_valid

          expect(flow2.errors.messages[:starts_at]).to include 'не может пересекаться с датами существующего потока'
          expect(flow2.errors.messages[:finishes_at]).to include 'не может пересекаться с датами существующего потока'
        end

        it 'should fail if other flow period is inside current period' do
          flow2.starts_at = flow1.starts_at - 1.hour

          expect(flow2).not_to be_valid

          expect(flow2.errors.messages[:starts_at]).to include 'не может пересекаться с датами существующего потока'
          expect(flow2.errors.messages[:finishes_at]).to include 'не может пересекаться с датами существующего потока'
        end

        it 'should fail if period is inside other flow period' do
          flow2.starts_at = flow1.starts_at + 1.hour
          flow2.finishes_at = flow1.finishes_at - 1.hour
          flow2.checks_finish_at = flow1.starts_at + 2.hour

          expect(flow2).not_to be_valid

          expect(flow2.errors.messages[:starts_at]).to include 'не может пересекаться с датами существующего потока'
          expect(flow2.errors.messages[:finishes_at]).to include 'не может пересекаться с датами существующего потока'
        end

        it 'should fail if finishes_at in other flow period' do
          flow2.starts_at = flow1.starts_at - 1.hour
          flow2.finishes_at = flow1.starts_at + 1.hour
          flow2.checks_finish_at = flow1.starts_at

          expect(flow2).not_to be_valid

          expect(flow2.errors.messages[:starts_at]).to include 'не может пересекаться с датами существующего потока'
          expect(flow2.errors.messages[:finishes_at]).to include 'не может пересекаться с датами существующего потока'
        end
      end

      context 'when flows are in different course' do
        let(:course2) { insert(:course) }
        let!(:flow1) { insert(:flow, course: course) }
        let(:flow2) { create(:flow, course: course2) }

        it 'should pass if starts_at in other flow period' do
          flow2.starts_at = flow1.finishes_at - 1.hour

          expect(flow2).to be_valid
        end
      end
    end

    describe '#checks_finish_at_between_starts_at_and_finishs_at' do
      let(:flow) { Flow.new(starts_at: Time.zone.now + 1.day,
                            checks_finish_at: Time.zone.now + 2.days,
                            finishes_at: Time.zone.now + 3.days) }

      it 'should pass if checks_finish_at is between starts_at and finishes_at' do
        flow.valid?

        expect(flow.errors.messages[:checks_finish_at]).not_to include 'не может быть раньше начала или позже конца потока'
      end

      it 'should fail if checks_finish_at is less than starts_at' do
        flow.checks_finish_at = flow.starts_at - 1.hour
        flow.valid?

        expect(flow.errors.messages[:checks_finish_at]).to include 'не может быть раньше начала или позже конца потока'
      end

      it 'should fail if checks_finish_at is greater than finishes_at' do
        flow.checks_finish_at = flow.finishes_at + 1.hour
        flow.valid?

        expect(flow.errors.messages[:checks_finish_at]).to include 'не может быть раньше начала или позже конца потока'
      end
    end
  end

  describe 'state_machine' do
    context 'in in_future state' do
      context 'validation' do
        context 'when starts_at, checks_finish_at and finishes_at are in past' do
          let(:flow) { Flow.new(starts_at: Time.zone.now - 3.day,
                                checks_finish_at: Time.zone.now - 2.days,
                                finishes_at: Time.zone.now - 1.days) }

          it 'should fail' do
            expect(flow.in_future?).to eq true
            flow.valid?

            expect(flow.errors.messages[:starts_at]).to include 'должно быть в будующем'
            expect(flow.errors.messages[:checks_finish_at]).to include 'должно быть в будующем'
            expect(flow.errors.messages[:finishes_at]).to include 'должно быть в будующем'
          end

          context 'if state is not in_future' do
            it 'should pass' do
              flow.state = 'active'

              flow.valid?

              expect(flow.errors.messages[:starts_at]).not_to include 'должно быть в будующем'
              expect(flow.errors.messages[:checks_finish_at]).not_to include 'должно быть в будующем'
              expect(flow.errors.messages[:finishes_at]).not_to include 'должно быть в будующем'
            end
          end
        end

        context 'when starts_at, checks_finish_at and finishes_at are in future' do
          let(:flow) { Flow.new(starts_at: Time.zone.now + 1.day,
                                checks_finish_at: Time.zone.now + 2.days,
                                finishes_at: Time.zone.now + 3.days) }

          it 'should pass' do
            expect(flow.in_future?).to eq true
            flow.valid?

            expect(flow.errors.messages[:starts_at]).not_to include 'должно быть в будующем'
            expect(flow.errors.messages[:checks_finish_at]).not_to include 'должно быть в будующем'
            expect(flow.errors.messages[:finishes_at]).not_to include 'должно быть в будующем'
          end
        end
      end
    end

    context 'callback' do
      context 'after_transition' do
        let(:user) { insert(:user) }
        let(:course) { insert(:course) }
        let(:flow) { insert(:flow, course: course) }
        let!(:user_course) { create(:user_course, flow: flow, course: course, paid: true) }

        describe '#activate_accesses' do
          it 'should activate user_courses' do
            flow.start

            expect(user_course.reload).to be_active
          end
        end

        describe '#finish_user_courses_checks' do
          let(:flow) { insert(:flow, course: course, state: :active) }
          let!(:user_course1) { create(:user_course, flow: flow, course: course, state: :active) }

          it 'should finish checks for activated user_courses' do
            flow.finish_checks

            expect(user_course.reload).to be_inactive
            expect(user_course1.reload).to be_checks_finished
          end
        end

        describe '#finish_user_courses_checks' do
          let(:flow) { insert(:flow, course: course, state: :checks_finished) }
          let!(:user_course1) { create(:user_course, flow: flow, course: course, state: :active) }
          let!(:user_course2) { create(:user_course, flow: flow, course: course, state: :checks_finished) }

          it 'should finish checks for activated user_courses' do
            flow.finish

            expect(user_course.reload).to be_inactive
            expect(user_course1.reload).to be_finished
            expect(user_course2.reload).to be_finished
          end
        end
      end
    end
  end

  describe '.change_states' do
    let!(:flow1) { insert(:flow) }
    let!(:flow2) { insert(:flow, starts_at: Time.zone.now - 1.hour) }

    let!(:flow3) { insert(:flow, state: :active) }
    let!(:flow4) { insert(:flow, state: :active, checks_finish_at: Time.zone.now - 1.hour) }

    let!(:flow5) { insert(:flow, state: :checks_finished) }
    let!(:flow6) { insert(:flow, state: :checks_finished, finishes_at: Time.zone.now - 1.hour) }

    let!(:flow7) { insert(:flow, state: :finished) }

    before do
      allow_any_instance_of(Flow).to receive(:valid?).and_return(true)

      Flow.change_states
    end

    it 'should change states where time came' do
      expect(flow1.reload).to be_in_future
      expect(flow2.reload).to be_active

      expect(flow3.reload).to be_active
      expect(flow4.reload).to be_checks_finished

      expect(flow5.reload).to be_checks_finished
      expect(flow6.reload).to be_finished

      expect(flow7.reload).to be_finished
    end
  end
end
