{ lib, fetchFromGitLab, python3Packages
, gitMinimal, rpm, dpkg, fakeroot
}:

python3Packages.buildPythonApplication rec {
  pname = "apkg";
  version = "0.3.1.p1";

  src = fetchFromGitLab {
    domain = "gitlab.nic.cz";
    owner = "packaging";
    repo = pname;
    #rev = "v${version}";
    rev = "bb68ed7";
    sha256 = "kyVLpfSG8NjhgbAej0ubhCxDfWgrHssrZoQQZeFNvwo=";
  };

  propagatedBuildInputs = with python3Packages; [
    # copy&pasted requirements.txt (almost exactly)
    beautifulsoup4   # upstream version detection
    blessings        # terminal colors
    build            # apkg distribution
    cached-property  # for python <= 3.7; but pip complains even with 3.8
    click            # nice CLI framework
    distro           # current distro detection
    jinja2           # templating
    packaging        # version parsing
    requests         # HTTP for humans™
    toml             # config files

    # further deps?
    setuptools
  ];

  makeWrapperArgs = [ # deps for `srcpkg` operation for other distros; could be optional
    "--prefix" "PATH" ":" (lib.makeBinPath [ gitMinimal rpm dpkg fakeroot ])
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
