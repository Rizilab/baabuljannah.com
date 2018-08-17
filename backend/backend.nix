{ mkDerivation, aeson, base, beam-core, beam-migrate, beam-postgres
, blaze-html, bytestring, containers, cryptonite, jwt, mtl, network
, optparse-generic, postgresql-simple, servant, servant-blaze
, servant-client, servant-docs, servant-snap, servant-swagger, snap
, snap-core, snap-server, stdenv, text, time, wai, warp, warp-tls
, websockets
}:
mkDerivation {
  pname = "backend";
  version = "0.0.1.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base beam-core beam-migrate beam-postgres blaze-html
    bytestring containers cryptonite jwt mtl network optparse-generic
    postgresql-simple servant servant-blaze servant-client servant-docs
    servant-snap servant-swagger snap snap-core snap-server text time
    wai warp warp-tls websockets
  ];
  license = stdenv.lib.licenses.bsd3;
}
