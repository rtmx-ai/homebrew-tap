class Aegis < Formula
  desc "Terminal-native agentic AI pair programmer for CUI environments"
  homepage "https://github.com/rtmx-ai/aegis-cli"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.2/aegis-0.1.2-macos-aarch64.tar.gz"
      sha256 "26e9c3c319641beab343526a9de5e015434665edd53e2ce3a8fd059cdaf5ec6b"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.2/aegis-0.1.2-macos-x86_64.tar.gz"
      sha256 "2b35eaade71c32efcc81d17f9a0ffcb9b9bc6f0706eb3b64348a1a873351d9cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.2/aegis-0.1.2-linux-aarch64.tar.gz"
      sha256 "8d6333ff9a670e05f99449ba6eda8b834d7cafeaa08f842273568a0d81813b31"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.2/aegis-0.1.2-linux-x86_64.tar.gz"
      sha256 "33dfd2ca1e2948e5fef829012c129ee2317552c4933c49e10b451c171fbf9f54"
    end
  end

  def install
    bin.install "aegis"
  end

  test do
    assert_match "aegis", shell_output("#{bin}/aegis --version")
  end
end
