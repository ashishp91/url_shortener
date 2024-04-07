require 'rails_helper'

RSpec.describe Link, type: :model do

  let(:github_home_link) { build(:github_home_link) }
  let(:ror_discuss_forum) { build(:ror_discuss_forum) }

  it "Fetches recent first links" do
    link_1 = create(:github_home_link, created_at: Time.now)
    link_2 = create(:ror_discuss_forum, created_at: Time.now + 5.seconds)

    expect(Link.recent_first.map(&:url)).to eq([link_2.url, link_1.url])
  end

  context "Updates metadata after save" do
    it "for link with title and description" do
      expect(MetadataService).to receive(:instance).and_call_original
      expect_any_instance_of(MetadataResponse).to receive(:description).and_return("")

      ror_discuss_forum.save
      ror_discuss_forum.reload

      expect(ror_discuss_forum.title).to eq('Ruby on Rails Discussions - Ruby on Rails Discussions')
      expect(ror_discuss_forum.description).to eq('Ruby on Rails Discussions')
    end

    it "for link without title and description" do
      expect(MetadataService).to receive(:instance).and_call_original
      expect_any_instance_of(MetadataResponse).to receive(:title).and_return("")
      expect_any_instance_of(MetadataResponse).to receive(:description).and_return("")

      github_home_link.save
      github_home_link.reload

      expect(github_home_link.title).to eq("")
      expect(github_home_link.description).to eq("")
    end
  end

  context "Finds link by code" do
    let(:github_home_link) { create(:github_home_link) }

    it "for github link" do
      link = Link.find_by_code(github_home_link.to_param)
      expect(link.url).to eq(github_home_link.url)
    end
  end

  context "validations" do
    let(:invalid_link) { build(:invalid_link) }
    let(:link) { build(:link) }

    it "doesnt allow links with invalid url" do
      invalid_link.save
      expect(invalid_link.errors.messages).to eq({:url=>["Invalid url"]})
    end

    it "doesnt allow links with empty link" do
      link.save
      expect(link.errors.messages).to eq({:url=>["can't be blank", "Invalid url"]})
    end
  end

  context "user behavior" do
    let(:user) { FactoryBot.build(:sample_user) }

    it "allows links without user" do
      github_home_link.save
      github_home_link.reload

      expect(github_home_link.user).to be_nil
      expect(github_home_link.id).not_to be_nil
    end

    it "allows links associated with a user" do
      user.save
      user.reload
      github_home_link.user_id = user.id

      github_home_link.save
      github_home_link.reload

      expect(github_home_link.user_id).to eq(user.id)
      expect(github_home_link.id).not_to be_nil
    end
  end

end
