class RefineVibeCode < Formula
  include Language::Python::Virtualenv

  desc "CLI tool to refine your code vibes"
  homepage "https://github.com/CarlosMenke/refine-vibe-code"
  url "https://files.pythonhosted.org/packages/source/r/refine-vibe-code/refine_vibe_code-0.1.0.tar.gz"
  sha256 "45d43f36b6b80319b70a81d0e5ccb932f9c3c7dbfc4f5a2e6bdbb5953c2c403f"

  depends_on "python@3.12"
  depends_on "rust" => :build

  # Run `brew update-python-resources` to fill this area automatically
  resource "typer" do
    url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.15.1.tar.gz"
    sha256 "0f3f22442576b50e32630739994b638ed3a60c04481b23838426027a7c0616b6"

  end

  def install
    # Create the virtualenv in the libexec directory
    venv = virtualenv_create(libexec, "python3.12")

    # Install the formula and its resources into the virtualenv
    venv.pip_install resources
    venv.pip_install_and_link buildpath

    # If the package installs a script named 'refine-vibe-code' 
    # but you want the user to type 'refine', we create a symlink:
    if (libexec/"bin/refine-vibe-code").exist?
      bin.install_symlink libexec/"bin/refine-vibe-code" => "refine"
    end
  end

  test do
    # This checks that 'refine' is in the path and executes
    system "#{bin}/refine", "--help"
  end
end
