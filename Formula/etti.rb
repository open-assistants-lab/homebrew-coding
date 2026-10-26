# Generated from an exact local archive; publish only after release approval/gates.
class Etti < Formula
  desc "Experimental coding assistant"
  homepage "https://github.com/open-assistants-lab/homebrew-coding"
  url "https://github.com/open-assistants-lab/homebrew-coding/releases/download/v0.1.3/etti-0.1.3-596959e59a70-macos-arm64.tar.gz"
  sha256 "76ce2deaf094bd627b1f6e8b7e9e580e88d59a7c8af2d50fd758593f098effef"
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
      Use a separate --state-dir for another project. Upgrades may need Keychain reauthorization.
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
