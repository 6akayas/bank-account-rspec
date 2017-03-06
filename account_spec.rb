require "rspec"

require_relative "account"

describe Account do

  let(:acct_number)         { '0123456789' }
  let(:starting_balance)    { 0 }
  let(:transactions)        { [starting_balance] }
  let(:amount)              { Integer }
  let(:account)             { Account.new(acct_number, starting_balance) }

  describe "#initialize" do
    it "take two arguments" do
      expect(Account.new(acct_number, starting_balance)).to be_a_kind_of(Account)
    end

    it "requires two argument" do
      expect { Account.new }.to raise_error(ArgumentError)
    end
  end

  describe "#transactions" do
    subject{ account.transactions }

    context "when an account started with 0 and deposited $100" do
      before do
        account.instance_variable_set(:@transactions, [0,100])
      end

      context "when I deposit $12" do
        before do
          account.deposit!(12)
        end
        it { should eq [0,100,12] }
      end
    end
  end

  describe "#balance" do
    context "when I deposit to an empty account" do
      subject{ account.balance }
        before do
          account.deposit!(1)
        end
      it { should eq(1) }
    end
  end

  describe "#account_number" do
    it "should show only last 4 digits of account_number" do
      expect(account.acct_number).to eq('******6789')
    end
  end

  describe "deposit!" do
    context "when the amount deposited is negative" do
      subject{ account.deposit!(-3) }
        it "should raise NegativeDepositError" do
          expect{ subject }.to raise_error(Account::NegativeDepositError)
        end
    end

    it "should add an transaction to the balance" do
      expect(account.deposit!(12)).to eq(12)
      end
  end

  describe "#withdraw!" do
    context "when I withdraw more money than the balance" do
    subject{ account.withdraw!(120) }
    it "should raise OverdraftError" do
      expect{ subject }.to raise_error(Account::OverdraftError)
      end
    end
  end
end
