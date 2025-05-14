class Bureaucrat < Formula
  desc "Automatically add issue tracking IDs to your Git commits"
  homepage "https://github.com/arttuperala/bureaucrat"
  url "https://github.com/arttuperala/bureaucrat/archive/refs/tags/0.1.0.tar.gz"
  sha256 "98eb759400ea70b26aa336e1f8e6d224b16d1ebf6dfd04bcf141a4a3dc9a5ce9"
  license "MIT"
  head "https://github.com/arttuperala/bureaucrat.git", branch: "master"

  bottle do
    root_url "https://github.com/arttuperala/homebrew-bureaucrat/releases/download/bureaucrat-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8df17844c1e0846da42e5c0b0109cb0835f6ab8a759b395858a195ed52082712"
    sha256 cellar: :any_skip_relocation, ventura:       "9b1b5063b428b503105b656f0743ff337e6fbab8ff8efae155437a95c5ff9e51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "817732ba73d345eeff2900cd724641d940e41217b4d4b400d1480ccfc2bd2997"
  end

  depends_on "rust" => :build

  uses_from_macos "zlib"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "git", "init"
    assert_match "Hook installed at .git/hooks/prepare-commit-msg", shell_output("#{bin}/bureaucrat install 2>&1")
    assert_path_exists testpath/".git/hooks/prepare-commit-msg"
  end
end
