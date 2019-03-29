import Test.DocTest
import System.Process

main :: IO ()
main = do
  gobjectIntrospectionLibs <- pkgConfigLibs "gobject-introspection-1.0"
  doctest $ [ "-XCPP", "-XOverloadedStrings", "-XRankNTypes", "-XLambdaCase"
            , "-ilib"
            -- For the autogenerated Data.GI.CodeGen.GType (hsc)
            , "-idist/build"
            , "dist/build/lib/c/enumStorage.o"
            ] ++ gobjectIntrospectionLibs ++
            -- The actual modules to test
            [ "Data.GI.CodeGen.GtkDoc"
            , "Data.GI.CodeGen.ModulePath"
            , "Data.GI.CodeGen.SymbolNaming"
            , "Data.GI.CodeGen.Haddock" ]

pkgConfigLibs :: String -> IO [String]
pkgConfigLibs pkg = words <$> readProcess "pkg-config" ["--libs", pkg] ""