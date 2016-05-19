class Nextflow < Formula
  desc "Data-driven computational pipelines"
  homepage "http://www.nextflow.io/"
  # doi "10.6084/m9.figshare.1254958"
  # tag "bioinformatics"

  url "http://www.nextflow.io/releases/v0.19.1/nextflow"
  version "0.19.1"
  sha256 "139ab98592b8e5dd434a31672505f55442633eecb933f1fef28c89aa9132a57e"

  head "https://github.com/nextflow-io/nextflow.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "48216bf5a5204398c748e27440b3cc388df2571e23234d2f232fbb16b354104a" => :el_capitan
    sha256 "7b7b9a2c0d75ed390e937e7239b87ca07cc886084f0e96290fdc463f74913a64" => :yosemite
    sha256 "555c5ff08aa49cff333dbd7b07468851c00c99745cde3c130723dc956625ada9" => :mavericks
  end

  depends_on :java => "1.7+"

  def install
    bin.install "nextflow"
  end

  test do
    system "#{bin}/nextflow", "-download"
    system "echo", "println \'hello\' | #{bin}/nextflow -q run - |grep hello"
  end
end
