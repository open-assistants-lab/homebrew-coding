# Generated from two reopened exact-source archives; publication requires exact-set approval.
class Etti < Formula
  desc "Experimental coding assistant"
  homepage "https://github.com/open-assistants-lab/homebrew-coding"
  license "MIT"

  depends_on "open-assistants-lab/telemetry/odograph"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.13/etti-0.1.13-de7e0d3830c9-macos-arm64.tar.gz"
    sha256 "40cd597ed1ba8637d6ed86747958388e5c796949b1b0f7a94f3379d2e521a460"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.13/etti-0.1.13-de7e0d3830c9-linux-x86_64-musl.tar.gz"
    sha256 "4f821abd0fe26eb386acda166bdf747a6bbc44dc95175d3551f8eab6c072c0d6"
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
      Stores: this release stores in SQLite. A store written by an earlier release (Etti
      0.1.7-0.1.11, DuckDB) is refused as store_format before it opens.
      There is no migration or read-old path, and the store is never deleted or rewritten.
      Start a fresh state directory only deliberately, or restore a pre-cutover backup taken
      before the cut and open that copy with the earlier release that wrote it.
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
