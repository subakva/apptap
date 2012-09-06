require 'formula'

class MakeAwesome < Formula
  homepage 'https://github.com/subakva/apptap'
  url 'https://github.com/downloads/subakva/apptap/make_awesome.sh'
  md5 '58c90ea35ac54166e31209a6139d8c09'

  def install
    bin.install 'make_awesome.sh'
  end
end
