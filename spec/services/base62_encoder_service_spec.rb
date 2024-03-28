require 'rails_helper'

RSpec.describe Base62EncoderService, type: :service do

  context "Encodes valid values" do
    it "encodes 0" do
      expect(Base62EncoderService.encode(0)).to eq("0")
    end

    it "encodes 1" do
      expect(Base62EncoderService.encode(1)).to eq("1")
    end

    it "encodes 10" do
      expect(Base62EncoderService.encode(10)).to eq("a")
    end

    it "encodes 62" do
      expect(Base62EncoderService.encode(62)).to eq("10")
    end

    it "encodes 1024" do
      expect(Base62EncoderService.encode(1024)).to eq("gw")
    end

    it "encodes 999_999" do
      expect(Base62EncoderService.encode(999_999)).to eq("4c91")
    end
  end

  context "Decodes valid values" do
    it "decodes 0" do
      expect(Base62EncoderService.decode("0")).to eq(0)
    end

    it "decodes 1" do
      expect(Base62EncoderService.decode("1")).to eq(1)
    end

    it "decodes 10" do
      expect(Base62EncoderService.decode("a")).to eq(10)
    end

    it "decodes 62" do
      expect(Base62EncoderService.decode("10")).to eq(62)
    end

    it "decodes 1024" do
      expect(Base62EncoderService.decode("gw")).to eq(1024)
    end

    it "decodes 999_999" do
      expect(Base62EncoderService.decode("4c91")).to eq(999_999)
    end
  end

  context "Handles invalid values" do
    it "when encoding -1" do
      expect(Base62EncoderService.encode(-1)).to eq("")
    end

    it "when encoding nil" do
      expect(Base62EncoderService.encode(nil)).to eq("")
    end

    it "when decoding nil" do
      expect(Base62EncoderService.decode(nil)).to eq(nil)
    end

    it "when encoding empty value" do
      expect(Base62EncoderService.encode("")).to eq("")
    end

    it "when decoding empty value" do
      expect(Base62EncoderService.decode("")).to eq("")
    end
  end

end
