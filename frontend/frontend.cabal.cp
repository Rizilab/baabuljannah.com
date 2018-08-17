name: frontend
version: 0.1
cabal-version: >= 1.8
build-type: Simple

extra-source-files:
    README.md

executable frontend
  main-is: main.hs
  hs-source-dirs: src
  build-depends: base
               , reflex-dom
               , text
               -- custom package
               , reflex
               , mtl
               , transformers
               , aeson
               , filepath
               , lens
               , bytestring
               , containers
               , email-validate
               , uri-bytestring
               , ref-tf
               , exception-transformers
               , dependent-sum
               , dependent-map
               , ghcjs-dom
               , ghcjs-base
               , jsaddle
               , reflex-dom-nested-routing
               , reflex-dom-storage
               , reflex-dom-contrib

  other-modules:
      UI
    , Util.Button
    , Util.Collection
    , Util.Bulma.Components.Navbar
    , Web
    , Web.Aktivitas
    , Web.Footer
    , Web.Navigation
    , Web.Landing
    , Web.Media
    , Web.Media.Berita
    , Web.Media.Publikasi
    , Web.Media.SiaranPers
    , Web.Tentang
    , Web.Tentang.DKM
    , Web.Tentang.Galeri
    , Web.Tentang.LaporanTahunan
    , Web.Tentang.Sejarah
    , Web.Tentang.VisiMisi

  default-language: Haskell2010

  --TODO: Make these ghc-options optional
  --ghc-options: -threaded -rtsopts -with-rtsopts=-N -fno-warn-unused-do-bind -fwarn-tabs -funbox-strict-fields -O2 -fprof-auto-calls -fexpose-all-unfoldings
  --if os(darwin)
  --   ghc-options: -dynamic
  --if impl(ghcjs -any)
  --  ghc-options: -threaded -rtsopts -with-rtsopts=-N -fno-warn-unused-do-bind -fwarn-tabs -funbox-strict-fields -O2 -fprof-auto-calls -fexpose-all-unfoldings -dedupe
  --  cpp-options: -D_GHCJS_ -DGHCJS_GC_INTERVAL=60000 -DGHCJS_BROWSER
