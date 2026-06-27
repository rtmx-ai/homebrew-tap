class Aegis < Formula
  desc "Terminal-native agentic AI pair programmer for CUI environments"
  homepage "https://github.com/rtmx-ai/aegis-cli"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.3/aegis-0.1.3-macos-aarch64.tar.gz"
      sha256 "30d79f8b4a6da7f14bf418a78771b17d319481f144829cbb815065cd0ea43ad0"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.3/aegis-0.1.3-macos-x86_64.tar.gz"
      sha256 "df34ea54bde1603c8a5a156b7826107ed521917a5fa4b6c3b5e679571837c63f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.3/aegis-0.1.3-linux-aarch64.tar.gz"
      sha256 "dc1c8f6981327b286c7dce90e97c8144db4d504db5942f88ccd795938bc260af"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.3/aegis-0.1.3-linux-x86_64.tar.gz"
      sha256 "5779f859bb5016378f0337612027b95f64b6f509b75dff872b1b97901f01dc9b"
    end
  end

  def install
    bin.install "aegis"
  end

  test do
    assert_match "aegis", shell_output("#{bin}/aegis --version")
  end
end
