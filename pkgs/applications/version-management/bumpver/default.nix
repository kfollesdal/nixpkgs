{ lib, python3, git, mercurial}:

python3.pkgs.buildPythonApplication rec {
  pname = "bumpver";
  version = "2020.1107";

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "75704333a8d1699e2cadcf1fcd3027a2cab6837ae343af10a61c6eef4e0313d7";
  };

  propagatedBuildInputs = with python3.pkgs; [ pathlib2 click toml lexid colorama lib3to6 setuptools ];

  checkInputs = [ python3.pkgs.pytestCheckHook git mercurial];

  meta = with lib; {
    description = "Bump version numbers in project files";
    homepage = "https://pypi.org/project/bumpver/";
    license = licenses.mit;
    maintainers = with maintainers; [ kfollesdal ];
  };
}
