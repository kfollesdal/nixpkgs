{ lib, buildPythonPackage, fetchPypi, pytestCheckHook, pathlib2, astor, click, wheel }:

buildPythonPackage rec {
  pname = "lib3to6";
  version = "202009.1044";

  src = fetchPypi {
    inherit pname version;
    sha256 = "2f88bea589bdcc82ffa60a9b56ae8e0a65b3c9be738c248086075605fd0fa236";
  };

  propagatedBuildInputs = [ pathlib2 astor click wheel ];

  checkInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "Compile Python 3.6+ code to Python 2.7+";
    homepage = "https://pypi.org/project/lib3to6/";
    license = licenses.mit;
    maintainers = with maintainers; [ kfollesdal ];
  };
}
