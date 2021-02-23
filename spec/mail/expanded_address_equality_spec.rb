require "mail"

RSpec.describe Mail::Address do
  after(:each) { Mail.disable_expanded_address_comparison }

  let(:address_only) { "don@werve.net" }

  let(:with_display_name) { "Don Werve <don@werve.net>" }

  describe "==" do
    describe "Mail.disable_expanded_address_comparison" do
      before(:each) { Mail.disable_expanded_address_comparison }

      describe "against String" do
        it { expect(Mail::Address.new(address_only))
          .to_not eq(address_only) }

        it { expect(Mail::Address.new(with_display_name))
          .to_not eq(with_display_name) }

        it { expect(Mail::Address.new(address_only))
          .to_not eq(with_display_name) }

        it { expect(Mail::Address.new(with_display_name))
          .to_not eq(address_only) }
      end

      describe "against Mail::Address" do
        it { expect(Mail::Address.new(address_only))
          .to_not eq(Mail::Address.new(address_only)) }

        it { expect(Mail::Address.new(with_display_name))
          .to_not eq(Mail::Address.new(with_display_name)) }

        it { expect(Mail::Address.new(address_only))
          .to_not eq(Mail::Address.new(with_display_name)) }

        it { expect(Mail::Address.new(with_display_name))
          .to_not eq(Mail::Address.new(address_only)) }
      end
    end

    describe "Mail.enable_expanded_address_comparison" do
      before(:each) { Mail.enable_expanded_address_comparison }

      describe "against String" do
        it { expect(Mail::Address.new(address_only))
          .to eq(address_only) }

        it { expect(Mail::Address.new(with_display_name))
          .to eq(with_display_name) }

        it { expect(Mail::Address.new(address_only))
          .to_not eq(with_display_name) }

        it { expect(Mail::Address.new(with_display_name))
          .to_not eq(address_only) }
      end

      describe "against Mail::Address" do
        it { expect(Mail::Address.new(address_only))
          .to eq(Mail::Address.new(address_only)) }

        it { expect(Mail::Address.new(with_display_name))
          .to eq(Mail::Address.new(with_display_name)) }

        it { expect(Mail::Address.new(address_only))
          .to_not eq(Mail::Address.new(with_display_name)) }

        it { expect(Mail::Address.new(with_display_name))
          .to_not eq(Mail::Address.new(address_only)) }
      end
    end
  end
end

RSpec.describe Mail::AddressList do
  before(:each) { Mail.disable_expanded_address_comparison }

  after(:each) { Mail.disable_expanded_address_comparison }

  let(:address_only) { "alice@wonderland.net, cat@wonderland.net" }

  let(:with_display_name) { "Alice Liddell <alice@wonderland.net>, " \
    + "Cheshire Cat <cat@wonderland.net>" }

  let(:with_groups) { \
    "Wonderlanders: Alice Liddell <alice@wonderland.net>, " \
    + "Cheshire Cat <cat@wonderland.net>;" }

  describe "==" do
    describe "Mail.disable_expanded_address_comparison" do
      before(:each) { Mail.disable_expanded_address_comparison }

      describe "against String" do
        it { expect(Mail::AddressList.new(address_only))
          .to_not eq(address_only) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(with_display_name) }

        it { expect(Mail::AddressList.new(with_groups))
          .to_not eq(with_groups) }

        it { expect(Mail::AddressList.new(address_only))
          .to_not eq(with_display_name) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(address_only) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(with_groups) }
      end

      describe "against Mail::AddressList" do
        it { expect(Mail::AddressList.new(address_only))
          .to_not eq(Mail::AddressList.new(address_only)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(Mail::AddressList.new(with_display_name)) }

        it { expect(Mail::AddressList.new(with_groups))
          .to_not eq(Mail::AddressList.new(with_groups)) }

        it { expect(Mail::AddressList.new(address_only))
          .to_not eq(Mail::AddressList.new(with_display_name)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(Mail::AddressList.new(address_only)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(Mail::AddressList.new(with_groups)) }
      end
    end

    describe "Mail.enable_expanded_address_comparison" do
      before(:each) { Mail.enable_expanded_address_comparison }

      describe "against String" do
        it { expect(Mail::AddressList.new(address_only))
          .to eq(address_only) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to eq(with_display_name) }

        it { expect(Mail::AddressList.new(with_groups))
          .to eq(with_groups) }

        it { expect(Mail::AddressList.new(address_only))
          .to_not eq(with_display_name) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(address_only) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(with_groups) }
      end

      describe "against Array" do
        it { expect(Mail::AddressList.new(address_only))
          .to eq(address_only.split(/, /)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to eq(with_display_name.split(/, /)) }

        it { expect(Mail::AddressList.new(address_only))
          .to_not eq(with_display_name.split(/, /)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(address_only.split(/, /)) }
      end

      describe "against Mail::AddressList" do
        it { expect(Mail::AddressList.new(address_only))
          .to eq(Mail::AddressList.new(address_only)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to eq(Mail::AddressList.new(with_display_name)) }

        it { expect(Mail::AddressList.new(with_groups))
          .to eq(Mail::AddressList.new(with_groups)) }

        it { expect(Mail::AddressList.new(address_only))
          .to_not eq(Mail::AddressList.new(with_display_name)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(Mail::AddressList.new(address_only)) }

        it { expect(Mail::AddressList.new(with_display_name))
          .to_not eq(Mail::AddressList.new(with_groups)) }
      end
    end
  end
end
