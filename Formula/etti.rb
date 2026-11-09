# Generated from two reopened exact-source archives; publication requires exact-set approval.
class Etti < Formula
  desc "Experimental coding assistant"
  homepage "https://github.com/open-assistants-lab/homebrew-coding"
  license :cannot_represent

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.8/etti-0.1.8-02076a48d0e9-macos-arm64.tar.gz"
    sha256 "c70e591dd0dde485f364efac8bfee7de824781ff82b0272d3c81b57aeae7280e"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.8/etti-0.1.8-02076a48d0e9-linux-x86_64-musl.tar.gz"
    sha256 "8829f474b55287d10d4802c298f39bf41c2fb61930b9ad312dde443a4b57bf67"
  end

  def install
    bin.install "etti"
    doc.install "README.txt", "NOTICE.txt"
  end

  def caveats
    <<~EOS
      Experimental. Run `etti setup` explicitly to store your Ollama Cloud key.
      Setup stores locally; it does not authenticate the key or start inference.
      Tools share your OS user. Cloud coding requires Internet and can incur charges.
      Each project folder selects its own history; plain launches start fresh sessions.
      Setup writes private, unencrypted auth.json. No Keychain access or automatic migration.
      Keys and conversation stores are not deleted by uninstall.
    EOS
  end

  test do
    ENV["HOME"] = testpath.to_s
    ENV["XDG_CONFIG_HOME"] = (testpath/"config").to_s
    ENV["XDG_DATA_HOME"] = (testpath/"data").to_s
    ENV.delete("OLLAMA_API_KEY")
    ENV.delete("VERIFIED_CLOUD_MODEL_ID")
    ENV.delete("VERIFIED_CONTEXT_WINDOW")
    ENV.delete("OLLAMA_CLOUD_BASE_URL")
    system bin/"etti", "--help"
    system bin/"etti", "doctor"
  end
end
