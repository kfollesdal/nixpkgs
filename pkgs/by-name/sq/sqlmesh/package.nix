{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "sqlmesh";
  version = "0.123.3";
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "sqlmesh";
    hash = "sha256-zbtchTfu7IULZ2WYExnroU15i43iT9gVv1WfJyZvlO8=";
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

  pythonRelaxDeps = [ "sqlglot" ];

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

#  nativeCheckInputs = with python3.pkgs; [
#    pytestCheckHook
#    pytest-mock
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
