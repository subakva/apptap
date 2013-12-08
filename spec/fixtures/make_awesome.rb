require 'formula'

# Makes the system more awesome.
class MakeAwesome < Formula
  homepage 'https://github.com/subakva/apptap'
  url 'https://github.com/downloads/subakva/apptap/make_awesome.sh'
  sha256 'c9b0583609549e2f61d017ddb594b36eb7b56c905b302cd2a10378dff604132b'

  def install
    bin.install 'make_awesome.sh'
  end
end
