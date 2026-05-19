class Aegis < Formula
  desc "Terminal-native agentic AI pair programmer for CUI environments"
  homepage "https://github.com/rtmx-ai/aegis-cli"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.0/aegis-0.1.0-macos-aarch64.tar.gz"
      sha256 "db08cfcf2859e34c840d6b3c7fd4b737f8edf6c9b012399fbf07eab1f7f423af"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.0/aegis-0.1.0-linux-x86_64.tar.gz"
      sha256 "bb5991289f980f12e820fd3e3df158d8a25bf59082b0b33e4075152f80cbd08b"
    elsif Hardware::CPU.arm?
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.0/aegis-0.1.0-linux-aarch64.tar.gz"
      sha256 "86921a7f1c77687c9eb15fc7c665e09097fa71b3835e010a5ebf2d8465165d24"
    end
  end

  def install
    bin.install "aegis"
  end

  test do
    assert_match "aegis", shell_output("#{bin}/aegis --version")
  end
end
