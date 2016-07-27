require 'account'

describe Account do
  let(:account) { Account.new("0123456789") }
  let(:bad_account) {Account.new("123456789")}

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account" do
        # o = Object.new
        expect(account).to be_an_instance_of Account
      end
    end

    context "with invalid input" do
      it "throws an InvalidAccountNumberError when acct_number has less than 10 digits" do
        expect{bad_account}.to raise_error(InvalidAccountNumberError) #recordar que
        # las llaves son necesarias en la sintaxis de rspec, la logica era la correcta,
        # la sintaxis con (), no lo era
      end
    end
  end

  context "when using default starting_balance" do
    describe "#transactions" do
      it "returns the default starting_balance" do
        expect{account.starting_balance} == 0
      end
    end

    describe "#balance" do
      it "is 0" do
        expect{account.starting_balance} == 0
      end
    end
  end

  context "when initialized with a starting_balance" do
    let(:account) { Account.new("1234567890", 100) }

    describe "#transactions" do
      it "returns the specified balance" do
        expect{account.transactions[0]} == 100
      end
    end

    describe "#balance" do
      it "is the specified balance" do
        expect{account.balance} == 100
      end
    end

    describe "#withdraw!" do
      it "decreases the balance" do       
        expect{account.withdraw!(12)} == 88
      end

      it "substracts positive amounts" do
        expect{account.withdraw!(-12)} == 112
      end
    end
  end

  describe "#account_number" do
    it "masks the number of the account" do
      expect{account.acct_number} #aqui falta algo sobre la mascara
    end
  end

  describe "deposit!" do
    it "requires a positive amount" do
      expect{account.deposit!(-12)}.to raise_error(NegativeDepositError)
    end

    it "increases the balance of the account" do
      expect{account.deposit!(12)}.not_to raise_error(NegativeDepositError)
    end
  end

  describe "#withdraw!" do
    it "throws an OverdraftError when withdraw amount is bigger than balance" do
      expect{account.withdraw!(-101)}.to raise_error(OverdraftError)
    end
  end
end
