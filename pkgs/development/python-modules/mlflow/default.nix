{ lib
, alembic
, buildPythonPackage
, click
, cloudpickle
, databricks-cli
, docker
, entrypoints
, fetchPypi
, flask
, GitPython
, gunicorn
, importlib-metadata
, numpy
, packaging
, pandas
, prometheus-flask-exporter
, protobuf
, pytz
, pythonOlder
, pyyaml
, querystring_parser
, requests
, scipy
, sqlalchemy
, sqlparse
}:
let
mkMlflow = { hash, propagatedBuildInputs, skinny ? false }:
  buildPythonPackage rec {
    MLFLOW_SKINNY = skinny;

    pname = if !skinny then "mlflow" else "mlflow-skinny";
    version = "1.28.0";
    format = "setuptools";

    disabled = pythonOlder "3.7";

    src = fetchPypi {
      inherit pname version hash;
    };

    inherit propagatedBuildInputs;

    pythonImportsCheck = [
      "mlflow"
    ];

    # run into https://stackoverflow.com/questions/51203641/attributeerror-module-alembic-context-has-no-attribute-config
    # also, tests use conda so can't run on NixOS without buildFHSUserEnv
    doCheck = false;

    meta = with lib; {
      description = "Open source platform for the machine learning lifecycle";
      homepage = "https://github.com/mlflow/mlflow";
      license = licenses.asl20;
      maintainers = with maintainers; [ tbenst ];
    };
  };

# requirements/skinny-requirements.txt
skinnyRequrements = [
  click
  cloudpickle
  databricks-cli
  entrypoints
  GitPython
  pyyaml
  protobuf
  pytz
  requests
  packaging
  importlib-metadata
  sqlparse
];

# from setup.py and requirements/core-requirements.txt
coreRequrements = skinnyRequrements ++ [
  alembic
  docker
  flask
  numpy
  scipy
  pandas
  prometheus-flask-exporter
  querystring_parser
  sqlalchemy
  gunicorn
];

in {
  mlflow = mkMlflow {
    hash = "sha256-aXZp4eQuiHwzBQKuTw7WROgUvgas2pDOpEU57M4zSmQ=";
    propagatedBuildInputs = coreRequrements;
  };

  mlflow-skinny = mkMlflow {
    skinny = true;
    hash = "sha256-GEQNjkKHE/Q8Dg1LUg3OjASRAiTEVZ7Ij2w6o4imDsQ=";
    propagatedBuildInputs = skinnyRequrements;
  };
}
