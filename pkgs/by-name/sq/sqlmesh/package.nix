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
    setuptools
    setuptools-scm
  ];

   dependencies = with python3.pkgs; [
     astor
     click
     croniter
     duckdb
     dateparser
     freezegun
     #hyperscript
     importlib-metadata
     ipywidgets
     jinja2
     pandas
     pydantic
     requests
     rich[jupyter]
     ruamel-yaml
     #sqlglot[rs]
     sqlglot
   ];

  doCheck = false; # Do check when fetch from github

  pythonImportsCheck = [ "sqlmesh" ];

  meta = {
    description = "Efficient data transformation and modeling framework";
    homepage = "https://sqlmesh.com/";
    changelog = "https://github.com/TobikoData/sqlmesh/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ kfollesdal ];
  };
}
