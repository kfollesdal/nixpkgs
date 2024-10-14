{
  lib,
  buildPythonPackage,
  duckdb,
  fetchFromGitHub,
  pytestCheckHook,
  python-dateutil,
  setuptools-scm,
  sqlglotrs,
}:

buildPythonPackage rec {
  pname = "sqlglot";
  version = "25.24.5";
  pyproject = true;

  src = fetchFromGitHub {
    repo = "sqlglot";
    owner = "tobymao";
    rev = "v${version}";
    hash = "sha256-YIK0gTzTYB+XMp0lYRWFm4vq1tjELPqFhNPaug1Y5d4=";
  };

  build-system = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    # Optional dependency used in the sqlglot optimizer
    # https://github.com/tobymao/sqlglot?tab=readme-ov-file#optional-dependencies
    python-dateutil
  ];

  passthru.optional-dependencies = {
    rs = [ sqlglotrs ];
  };

  nativeCheckInputs = [
    pytestCheckHook
    duckdb
  ];

  pythonImportsCheck = [ "sqlglot" ];

  meta = with lib; {
    description = "No dependency Python SQL parser, transpiler, and optimizer";
    homepage = "https://github.com/tobymao/sqlglot";
    changelog = "https://github.com/tobymao/sqlglot/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ cpcloud ];
  };
}
