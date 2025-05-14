class Bureaucrat < Formula
  desc "Automatically add issue tracking IDs to your Git commits"
  homepage "https://github.com/arttuperala/bureaucrat"
  url "https://github.com/arttuperala/bureaucrat/archive/refs/tags/0.1.0.tar.gz"
  sha256 "98eb759400ea70b26aa336e1f8e6d224b16d1ebf6dfd04bcf141a4a3dc9a5ce9"
  license "MIT"
  head "https://github.com/arttuperala/bureaucrat.git", branch: "master"

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
