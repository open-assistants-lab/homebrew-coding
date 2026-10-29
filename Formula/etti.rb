# Generated from an exact local archive; publish only after release approval/gates.
class Etti < Formula
  desc "Experimental coding assistant"
  homepage "https://github.com/open-assistants-lab/homebrew-coding"
  url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.4/etti-0.1.4-c5e644f9db95-macos-arm64.tar.gz"
  sha256 "0758d38a708c4343457b667429d119adce6480c704abed1369747cad6ceabbc0"
  license :cannot_represent

  depends_on arch: :arm64
  depends_on macos: :sonoma

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
