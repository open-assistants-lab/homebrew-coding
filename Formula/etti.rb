# Generated from two reopened exact-source archives; publication requires exact-set approval.
class Etti < Formula
  desc "Experimental coding assistant"
  homepage "https://github.com/open-assistants-lab/homebrew-coding"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.11/etti-0.1.11-aa93aec5a9a1-macos-arm64.tar.gz"
    sha256 "7515172e0bd0d7cb79adc296c25ee6f9675e209ee278c06139c6f9d11eb9f48f"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.11/etti-0.1.11-aa93aec5a9a1-linux-x86_64-musl.tar.gz"
    sha256 "1661cd8fa18fc4f454b0a2f04f7e6539cf64fd38a756991744a47803d83d6ef0"
  end

  def install
    bin.install "etti"
    doc.install "README.txt", "NOTICE.txt"
  end

  def caveats
    <<~EOS
      Experimental. Run `etti setup PROVIDER` explicitly to store that provider's key; the
      catalogued default is ollama-cloud, but setup is not Ollama-only.
      Setup stores locally in private, unencrypted auth.json; it does not authenticate the key
      or start inference. No Keychain access or automatic migration.
      Telemetry: the Langfuse and ClickStack targets are removed, and a leftover config naming
      either is refused by name. Only local odograph export remains; it is on by default and
      does nothing unless a local odograph advertises itself at
      $XDG_DATA_HOME/odograph/advertise.json or ~/.local/share/odograph/advertise.json.
      Stores: a DuckDB 1.5.6 store (Etti 0.1.7-0.1.9) is refused as store_format before it opens.
      There is no migration or read-old path, and the store is never deleted or rewritten.
      Start a fresh state directory only deliberately, or restore a pre-cutover backup taken
      before the cut and open that copy with the earlier 0.1.7-0.1.9 release that wrote it.
      Tools share your OS user. Cloud coding requires Internet and can incur charges.
      Each project folder selects its own history; plain launches start fresh sessions.
      Keys, configuration and conversation stores are not erased by uninstall.
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
