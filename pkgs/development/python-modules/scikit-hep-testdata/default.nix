{ lib
, fetchFromGitHub
, pythonAtLeast
, buildPythonPackage
, importlib-resources
, pyyaml
, requests
, pytestCheckHook
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "scikit-hep-testdata";
  version = "0.4.8";
  format = "pyproject";

  # fetch from github as we want the data files
  # https://github.com/scikit-hep/scikit-hep-testdata/issues/60
  src = fetchFromGitHub {
    owner = "scikit-hep";
    repo = pname;
    rev = "v${version}";
    sha256 = "0x5p42c9iqwdx15gdvccddlx4a5a8aix7h01345afrlgpnnpqcv4";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];
  propagatedBuildInputs = [
    pyyaml
    requests
  ] ++ lib.optional (!pythonAtLeast "3.9") importlib-resources;

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  SKHEP_DATA = 1; # install the actual root files

  doCheck = false; # tests require networking
  pythonImportsCheck = [ "skhep_testdata" ];

  meta = with lib; {
    homepage = "https://github.com/scikit-hep/scikit-hep-testdata";
    description = "A common package to provide example files (e.g., ROOT) for testing and developing packages against";
    license = licenses.bsd3;
    maintainers = with maintainers; [ veprbl ];
  };
}
