# frozen_string_literal: true

RSpec.describe Loan do
  let(:borrower)    { users(:user) }
  let(:volunteer) { users(:volunteer) }

  let(:carrier) { carriers(:carrier) }

  describe '#valid?' do
    context "with a borrower, a checkout volunteer, a carrier, and a due date" do
      subject do
        described_class.new(
          carrier: carrier,
          due_date: due_date,
          borrower: borrower,
          checkout_volunteer: volunteer
        )
      end

      let(:due_date) { DateTime.now + 1.days }

      it { is_expected.to be_valid }
    end
  end

  describe 'create' do
    it "sets the due date to the date specified" do
      due_date = 20.days.from_now.utc.to_date
      loan = described_class.create(
        carrier: carrier,
        borrower: borrower,
        checkout_volunteer: volunteer,
        due_date: due_date
      )

      expect(loan.due_date).to eq(due_date)
    end
  end

  context "without due date" do
    it "sets the due date to be the default number of days away" do
      freeze_time do
        loan = described_class.create(
          carrier: carrier,
          borrower: borrower,
          checkout_volunteer: volunteer
        )

        expect(loan.due_date).to eq(carrier.default_loan_length_days.days.from_now.utc.to_date)
      end
    end
  end

  describe '.outstanding' do
    it 'returns all outstanding loans' do
      described_class.delete_all
      loan_os1 = described_class.create(carrier: carrier,
                                        borrower: borrower,
                                        checkout_volunteer: volunteer,
                                        due_date: Time.zone.today + 10.days)
      outstanding_loans = carrier.loans.outstanding
      expect(outstanding_loans.size).to eq(1)
      expect(outstanding_loans.map(&:id)).to match_array([loan_os1.id])
    end
  end
end
