{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "sqlmesh";
  version = "0.126.2";
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "sqlmesh";
    hash = "sha256-5RYAR727OlBLVA6XPQ8C1Aba9Rqkhf7XVQwuc09RgP0=";
  };

  build-system = with python3.pkgs; [
    setuptools-scm
  ];

  dependencies = with python3.pkgs; [
    astor
    click
    croniter
    duckdb
    dateparser
    freezegun
    hyperscript
    importlib-metadata
    ipywidgets
    jinja2
    pandas
    pydantic
    requests
    rich
    rich.optional-dependencies.jupyter
    ruamel-yaml
    sqlglot
    sqlglot.optional-dependencies.rs
  ];

  pythonRelaxDeps = [
    "sqlglot"
  ];

  passthru.optional-dependencies = {
    web = with python3.pkgs; [
      fastapi
      watchfiles
      uvicorn
      uvicorn.optional-dependencies.standard
      sse-starlette
      pyarrow
    ];
  };

  doCheck = false; # Do check when fetch from github

  nativeCheckInputs = with python3.pkgs; [
    pytestCheckHook
  ];

#  checkInputs = with python3.pkgs; [
#    agate
#    beautifulsoup4
#    # ruff
#    cryptography
#    dbt-core
#    #missing dbt-duckdb
#    dbt-snowflake
#    dbt-bigquery
#    faker
#    google-auth
#    google-cloud-bigquery
#    google-cloud-bigquery-storage
#    mypy
#    # pre-commit
#    pandas-stubs
#    psycopg2-binary
#    pydantic
#    PyGithub
#    pytest-asyncio
#    pytest-mock
#    pytest-xdist
#    # missing pytest-retry
#    pyspark
#    pytz
#    snowflake-connector-python
#    snowflake-connector-python.optional-dependencies.pandas
#    snowflake-connector-python.optional-dependencies.secure-local-storage
#    # missing sqlalchemy-stubs
#    # missing types-croniter
#    # missing types-dateparser
#    types-python-dateutil
#    types-pytz
#    types-requests
#    typing-extensions
#    # missing custom-materializations
#  ] ++ [
#   # insecure apache-airflow
#  ];

  pythonImportsCheck = [ "sqlmesh" ];

  meta = {
    description = "Efficient data transformation and modeling framework";
    homepage = "https://sqlmesh.com/";
    changelog = "https://github.com/TobikoData/sqlmesh/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ kfollesdal ];
  };
}
