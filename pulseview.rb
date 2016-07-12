class Pulseview < Formula
  desc "Qt-based GUI for the sigrok software suite for DSOs, LSAs, and more."
  homepage "http://sigrok.org/"
  url "http://sigrok.org/download/source/pulseview/pulseview-0.3.0.tar.gz"
  sha256 "5ffe2cb7a602fcdc60933d400c77bcd66e6ce529bc4f6e97d6a5e5a86f2f530e"

  bottle do
    cellar :any
    sha256 "3a27f349741760f785416a6a83de6b2953f3c7992dafccc548af1858d5562f93" => :yosemite
    sha256 "d22cd4a9a9841760d57908e9d8cf3d563fb20932a207d8da3baa605436e7b0d9" => :mavericks
    sha256 "a8758f86e01c207d5662b67c9c118138aa7772c4e334f5b018192ff389c29998" => :mountain_lion
  end

  head do
    url "git://sigrok.org/pulseview", :shallow => false
    depends_on "glib"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build

  depends_on "boost"
  depends_on "libsigrokdecode"
  depends_on "qt"
  depends_on :python3

  def install
    # Let's make sure we use the correct version of python not just 3.4
    version = Language::Python.major_minor_version "python3"
    ENV.delete "PYTHONPATH"
    ENV.append_path "PKG_CONFIG_PATH", lib / "pkgconfig"
    ENV.append_path "PKG_CONFIG_PATH", HOMEBREW_PREFIX / "Frameworks/Python.framework/Versions/#{version}/lib/pkgconfig"

    qt = Formula["qt"].opt_prefix
    args = std_cmake_args + %W[
      -DPNG_INCLUDE_DIR=#{MacOS::X11.include}
      -DALTERNATIVE_QT_INCLUDE_DIR=#{qt}/include
    ]

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    system "#{bin}/pulseview", "-V"
  end
end
