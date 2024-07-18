{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  alembic,
  lz4,
  numpy,
  oauthlib,
  openpyxl,
  pandas,
  poetry-core,
  pyarrow,
  pytestCheckHook,
  pythonOlder,
  sqlalchemy,
  thrift,
  requests,
  urllib3,
  fetchpatch,
}:

buildPythonPackage rec {
  pname = "databricks-sql-connector";
  version = "3.2.0";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "databricks";
    repo = "databricks-sql-python";
    rev = "refs/tags/v${version}";
    hash = "sha256-Sk/tYgFnWWHAsMSHhEUIwUagc6femAzQpQGyzJGXW1E=";
  };

  patches = [
    (fetchpatch {
      name = "python-3.12.patch";
      url = "https://patch-diff.githubusercontent.com/raw/databricks/databricks-sql-python/pull/416.patch";
      sha256 = "sha256-sNCp8xSSmKP2yNzDK4wyWC5Hoe574AeHnKTeNcIxaek=";
    })
    ./fix2.patch
    # ./fix.patch
    
    # (fetchpatch {
    #   name = "python-3.12.patch";
    #   url = "https://patch-diff.githubusercontent.com/raw/databricks/databricks-sql-python/pull/414.patch";
    #   sha256 = "sha256-D/lR18aeuVJlmD2aCPDMXhTuSUnA6y5+szsgJboCClU=";
    # })
  ];

  # postPatch = ''
  #   echo "ABCD"
  #   ls
  #   substituteInPlace tests/unit/test_client.py \
  #     --replace 'called_with' 'assert_called_with'
  # '';

  pythonRelaxDeps = [
    "numpy"
    "thrift"
    # "pandas" ##### Remove
  ];

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    alembic
    lz4
    numpy
    oauthlib
    openpyxl
    pandas
    pyarrow
    sqlalchemy
    thrift
    requests
    urllib3
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pytestFlagsArray = [ "tests/unit" ];

  pythonImportsCheck = [ "databricks" ];

  meta = with lib; {
    description = "Databricks SQL Connector for Python";
    homepage = "https://docs.databricks.com/dev-tools/python-sql-connector.html";
    changelog = "https://github.com/databricks/databricks-sql-python/blob/v${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ harvidsen ];
  };
}
