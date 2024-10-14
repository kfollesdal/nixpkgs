{ lib
, buildPythonPackage
, rustPlatform
, pytestCheckHook
, sqlglot
, duckdb
}:

buildPythonPackage rec {
  pname = "sqlglotrs";
  version = sqlglot.version;
  pyproject = true;

  src = sqlglot.src;
  sourceRoot = "source/sqlglotrs";

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    sourceRoot = "source/sqlglotrs";
    hash = "sha256-6iehSPwaHlHL0WAjHLjpkCpPKnEeHDb8FLkxCcTLkM8=";
  };

  nativeBuildInputs = with rustPlatform; [
    cargoSetupHook
    maturinBuildHook
  ];

  nativeCheckInputs = [
    pytestCheckHook
    sqlglot
    duckdb
  ];

  preCheck = ''
    # sqlglotrs is a optional dependency that reimplements parts of SQLGlot in Rust
    # So to test have to use sqlglot test with sqlglotrs as dependency.
    cd ..
  '';

  pythonImportsCheck = [ "sqlglotrs" ];

  meta = with lib; {
    description = "Optional dependency for SQLGlot that reimplements parts of SQLGlot in Rust";
    homepage = "https://github.com/tobymao/sqlglot";
    changelog = "https://github.com/tobymao/sqlglot/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ kfollesdal ];
  };
}
