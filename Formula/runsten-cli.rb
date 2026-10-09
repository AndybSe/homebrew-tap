class RunstenCli < Formula
  desc "Universal, plugin-extensible CLI application framework and runtime kernel"
  homepage "https://github.com/AndybSe/runsten"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AndybSe/runsten/releases/download/v0.1.0/runsten-cli-aarch64-apple-darwin.tar.xz"
      sha256 "19860a19881322e5e338798442eeb9484b7847c6b6927fb6402c03ebffd13d4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AndybSe/runsten/releases/download/v0.1.0/runsten-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bae791df161db279bb9377ac28a777de811fd3d540b022ba79d7a7555752f619"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AndybSe/runsten/releases/download/v0.1.0/runsten-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e97d95abd417dba5d94ab83c92944a48cae87744416d641c4a86f9dd8f4a900"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AndybSe/runsten/releases/download/v0.1.0/runsten-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d8938108f38efbdfe6a81cb7256f93b36bddcc28641bddf607aeef0dbd57d4d0"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "runsten"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "runsten"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "runsten"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "runsten"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
