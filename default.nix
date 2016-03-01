{ mkDerivation, base, bytestring, ether, transformers, stdenv }:
mkDerivation {
  pname = "monad-network-class";
  version = "0.0.0.1";
  src = ./.;
  libraryHaskellDepends = [ base bytestring ether transformers ];
  homepage = "http://github.com/vladsor/monad-network-class";
  description = "Monad connection class";
  license = stdenv.lib.licenses.bsd3;
}
