{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "hyperscript";
  version = "0.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    repo = "hyperscript";
    owner = "vchan";
    rev = "v${version}";
    hash = "sha256-Xc1oMY4DdvrTzOElDN6TOxlQI4tByahF+oUZuJlTw/A=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "hyperscript" ];

  meta = with lib; {
    description = "HyperText with Python";
    homepage = "https://github.com/vchan/hyperscript";
    changelog = "https://github.com/vchan/hyperscript/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ kfollesdal ];
  };
}
