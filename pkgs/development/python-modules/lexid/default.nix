{ lib, buildPythonPackage, fetchPypi, pytestCheckHook, click }:

buildPythonPackage rec {
  pname = "lexid";
  version = "2020.1005";

  src = fetchPypi {
    inherit pname version;
    sha256 = "52333a2b9ebd14aa0dfeb33de72bd159c2dc31adb9c59cddfc486e2b69bfdcd1";
  };

  propagatedBuildInputs = [ click ];

  checkInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "lexid is a micro library to increment lexically ordered numerical ids";
    homepage = "https://pypi.org/project/lexid/";
    license = licenses.mit;
    maintainers = with maintainers; [ kfollesdal ];
  };
}
