require 'rails_helper'
describe Message do
  before(:each) do
    @message = Message.create(title_section: 'TITLE', q_section: 'Q - TEST', a_section: 'A - TEST', b_section: 'B - TEST', c_section: 'C - TEST', d_section: 'D - TEST', e_section: "AERODROME HOURS OF OPS/SERVICE. MON-THU 0530-2115, FRI 0530-2000, SAT 0730-1830, SUN 0730-2115", f_section: 'F - TEST')
  end

  describe "generate" do
    it "creates new message from string" do
      message = Message.new
      message.generate(["NOTAM", "Q) TEST A) TEST B) TEST C) TEST", "E) AERODROME HOURS OF OPS/SERVICE TEST"])
      message.save
      expect(message.title_section).to eq("NOTAM ")
      expect(message.q_section).to eq(' TEST ')
      expect(message.e_section).to eq(' AERODROME HOURS OF OPS/SERVICE TEST')
    end
  end

  describe "open_hours" do
    it "returns correct hash with open hours" do
      expect(@message.open_hours).to eq({:MON=>"0530-2115", :TUE=>"0530-2115", :WED=>"0530-2115", :THU=>"0530-2115", :FRI=>"0530-2000", :SAT=>"0730-1830", :SUN=>"0730-2115"})
    end
  end

  describe "scope" do
    it "returns scoped message" do
      expect(Message.aerodrome_hours.count).to eq(1)
    end
  end
end
