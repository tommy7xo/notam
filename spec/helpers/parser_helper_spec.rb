require 'rails_helper'

describe ParserHelper do
  describe '#to_hour' do
    subject { to_hour("TESTTESTTEST11223344") }
    it { expect(subject).to eq('1122-3344') }
  end

  describe '#to_hours' do
    subject { to_hours("TESTTESTTEST1122334455667788") }
    it { expect(subject).to eq("1122-3344\n5566-7788") }
  end

  describe '#exact_match' do
    subject { exact_match("TEST", "TEST1122-3344TEST-NEW4455-6677NEW-TEST7788-9900TESTCLOSED").to_s }
    it { expect(subject).to eq("TEST1122-3344") }
  end

  describe '#left_match' do
    subject { left_match("TEST", "TEST1122-3344TEST-NEW4455-6677NEW-TEST7788-9900TESTCLOSED").to_s }
    it { expect(subject).to eq("TEST-NEW4455-6677") }
  end

  describe '#right_match' do
    subject { right_match("TEST", "TEST1122-3344TEST-NEW4455-6677NEW-TEST7788-9900TESTCLOSED").to_s }
    it { expect(subject).to eq("NEW-TEST7788-9900") }
  end

  describe '#closed_match' do
    subject { closed_match("TEST", "TEST1122-3344TEST-NEW4455-6677NEW-TEST7788-9900TESTCLOSED").to_s }
    it { expect(subject).to eq("TESTCLOSED") }
  end
end