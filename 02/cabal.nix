{ mkDerivation, base, lib }:
mkDerivation {
  pname = "x02";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [ base ];
  license = lib.licenses.mit;
  mainProgram = "ack";
}
