{ lib, fetchFromGitLab, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "apkg";
  version = "0.1.1";

  src = fetchFromGitLab {
    domain = "gitlab.nic.cz";
    owner = "packaging";
    repo = pname;
    rev = "v${version}";
    sha256 = "0fwylw1dpaq37wqzrggcvh8hrjcxhmfws5xljwffaa2abnd9y85d";
  };

  propagatedBuildInputs = with python3Packages; [ # see requirements.txt
    # CORE REQUIREMENTS
    cached-property click distro jinja2 packaging requests toml
    # OPTIONAL REQUIREMENTS
    build
    # perhaps hard requirements?
    htmllistparse blessings
  ];

  checkInputs = with python3Packages; [ pytest ];
  checkPhase = "py.test"; # inspiration: .gitlab-ci.yml

  meta = with lib; {
    description = "Upstream packaging automation tool";
    homepage = "https://pkg.labs.nic.cz/pages/apkg";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.vcunat /* close to upstream */ ];
  };
}
