# sandbox-artifact-infrastructure/flake.nix
#
# This file packages rydnr/sandbox-artifact-infrastructure as a Nix flake.
#
# Copyright (C) 2023-today rydnr's rydnr/sandbox-artifact-infrastructure-artifact
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
{
  description = "Infrastructure layer for rydnr/sandbox-artifact";
  inputs = rec {
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    nixos.url = "github:NixOS/nixpkgs/nixos-23.05";
    pythoneda-shared-artifact-changes-events-infrastructure = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-artifact-changes-events.follows =
        "INDIRECT-pythoneda-shared-artifact-changes-events";
      # inputs.pythoneda-shared-artifact-changes-events.follows =
      #  "rydnr-sandbox-artifact/pythoneda-shared-artifact-changes-events";
      inputs.pythoneda-shared-code-requests-jupyterlab.follows =
        "INDIRECT-pythoneda-shared-code-requests-jupyterlab";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      inputs.pythoneda-shared-pythoneda-infrastructure.follows =
        "pythoneda-shared-pythoneda-infrastructure";
      url =
        "github:pythoneda-shared-artifact-changes/events-infrastructure-artifact/0.0.4?dir=events-infrastructure";
    };
    pythoneda-shared-pythoneda-banner = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      url = "github:pythoneda-shared-pythoneda/banner/0.0.13";
    };
    pythoneda-shared-pythoneda-domain = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      url =
        "github:pythoneda-shared-pythoneda/domain-artifact/0.0.12?dir=domain";
    };
    rydnr-sandbox-artifact = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-artifact-changes-events.follows =
        "INDIRECT-pythoneda-shared-artifact-changes-events";
      inputs.pythoneda-shared-git-shared.follows =
        "INDIRECT-INDIRECT-INDIRECT-INDIRECT-pythoneda-shared-git-shared";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url =
        "github:pythoneda-shared-pythoneda/domain-artifact-artifact/0.0.16?dir=domain-artifact";
    };
    pythoneda-shared-pythoneda-infrastructure = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url =
        "github:pythoneda-shared-pythoneda/infrastructure-artifact/0.0.6?dir=infrastructure";
    };
    INDIRECT-INDIRECT-INDIRECT-INDIRECT-pythoneda-shared-git-shared = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url = "github:pythoneda-shared-git/shared-artifact/0.0.4?dir=shared";
    };
    INDIRECT-INDIRECT-INDIRECT-pythoneda-shared-nix-flake-shared = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-git-shared.follows =
        "INDIRECT-INDIRECT-INDIRECT-INDIRECT-pythoneda-shared-git-shared";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url =
        "github:pythoneda-shared-nix-flake/shared-artifact/0.0.2?dir=shared";
    };
    INDIRECT-INDIRECT-pythoneda-shared-code-requests-events = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-code-requests-shared.follows =
        "INDIRECT-INDIRECT-pythoneda-shared-code-requests-shared";
      inputs.pythoneda-shared-nix-flake-shared.follows =
        "INDIRECT-INDIRECT-INDIRECT-pythoneda-shared-nix-flake-shared";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url =
        "github:pythoneda-shared-code-requests/events-artifact/0.0.2?dir=events";
    };
    INDIRECT-INDIRECT-pythoneda-shared-code-requests-shared = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      # inputs.pythoneda-shared-nix-flake-shared.inputs.pythoneda-shared-git-shared.follows = "rydnr-sandbox-artifact/pythoneda-shared-git-shared";
      # inputs.pythoneda-shared-nix-flake-shared.inputs.pythoneda-shared-git-shared.follows = "rydnr-sandbox-artifact/pythoneda-shared-git-shared";
      inputs.pythoneda-shared-nix-flake-shared.follows =
        "INDIRECT-INDIRECT-INDIRECT-pythoneda-shared-nix-flake-shared";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url =
        "github:pythoneda-shared-code-requests/shared-artifact/0.0.2?dir=shared";
    };
    INDIRECT-pythoneda-shared-artifact-changes-events = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-code-requests-shared.follows =
        "INDIRECT-INDIRECT-pythoneda-shared-code-requests-shared";
      inputs.pythoneda-shared-code-requests-events.follows =
        "INDIRECT-INDIRECT-pythoneda-shared-code-requests-events";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url =
        "github:pythoneda-shared-artifact-changes/events-artifact/0.0.4?dir=events";
    };
    INDIRECT-pythoneda-shared-code-requests-jupyterlab = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-code-requests-shared.follows =
        "INDIRECT-INDIRECT-pythoneda-shared-code-requests-shared";
      inputs.pythoneda-shared-nix-flake-shared.follows =
        "INDIRECT-INDIRECT-INDIRECT-pythoneda-shared-nix-flake-shared";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url =
        "github:pythoneda-shared-code-requests/jupyterlab-artifact/0.0.2?dir=jupyterlab";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        org = "rydnr";
        repo = "sandbox-artifact-infrastructure";
        version = "0.0.5";
        sha256 = "01v6lwlg6zjc9xr5rsal9dli6nf2sxfq55mymagdiz70cvva69wf";
        pname = "${org}-${repo}";
        pythonpackage = "rydnr.sandbox.artifact.infrastructure";
        pkgs = import nixos { inherit system; };
        description = "Infrastructure layer for rydnr/sandbox-artifact";
        license = pkgs.lib.licenses.gpl3;
        homepage = "https://github.com/${org}/${repo}";
        maintainers = with pkgs.lib.maintainers;
          [ "rydnr <github@acm-sl.org>" ];
        archRole = "B";
        space = "A";
        layer = "I";
        nixosVersion = builtins.readFile "${nixos}/.version";
        nixpkgsRelease =
          builtins.replaceStrings [ "\n" ] [ "" ] "nixos-${nixosVersion}";
        shared = import "${pythoneda-shared-pythoneda-banner}/nix/shared.nix";
        rydnr-sandbox-artifact-infrastructure-for = { python
          , pythoneda-shared-artifact-changes-events-infrastructure
          , pythoneda-shared-pythoneda-domain, rydnr-sandbox-artifact
          , pythoneda-shared-pythoneda-infrastructure }:
          let
            pnameWithUnderscores =
              builtins.replaceStrings [ "-" ] [ "_" ] pname;
            pythonVersionParts = builtins.splitVersion python.version;
            pythonMajorVersion = builtins.head pythonVersionParts;
            pythonMajorMinorVersion =
              "${pythonMajorVersion}.${builtins.elemAt pythonVersionParts 1}";
            wheelName =
              "${pnameWithUnderscores}-${version}-py${pythonMajorVersion}-none-any.whl";
          in python.pkgs.buildPythonPackage rec {
            inherit pname version;
            projectDir = ./.;
            pyprojectTemplateFile = ./pyprojecttoml.template;
            pyprojectTemplate = pkgs.substituteAll {
              authors = builtins.concatStringsSep ","
                (map (item: ''"${item}"'') maintainers);
              desc = description;
              inherit homepage pname pythonMajorMinorVersion pythonpackage
                version;
              package = builtins.replaceStrings [ "." ] [ "/" ] pythonpackage;
              pythonedaSharedArtifactChangesEventsInfrastructure =
                pythoneda-shared-artifact-changes-events-infrastructure.version;
              pythonedaSharedPythonedaDomain =
                pythoneda-shared-pythoneda-domain.version;
              pythonedaSharedPythonedaInfrastructure =
                pythoneda-shared-pythoneda-infrastructure.version;
              rydnrSandboxArtifact = rydnr-sandbox-artifact.version;
              src = pyprojectTemplateFile;
            };
            src = pkgs.fetchFromGitHub {
              owner = org;
              rev = version;
              inherit repo sha256;
            };

            format = "pyproject";

            nativeBuildInputs = with python.pkgs; [ pip pkgs.jq poetry-core ];
            propagatedBuildInputs = with python.pkgs; [
              pythoneda-shared-artifact-changes-events-infrastructure
              pythoneda-shared-pythoneda-domain
              rydnr-sandbox-artifact
              pythoneda-shared-pythoneda-infrastructure
            ];

            # pythonImportsCheck = [ pythonpackage ];

            unpackPhase = ''
              cp -r ${src} .
              sourceRoot=$(ls | grep -v env-vars)
              chmod +w $sourceRoot
              cp ${pyprojectTemplate} $sourceRoot/pyproject.toml
            '';

            postInstall = ''
              pushd /build/$sourceRoot
              for f in $(find . -name '__init__.py'); do
                if [[ ! -e $out/lib/python${pythonMajorMinorVersion}/site-packages/$f ]]; then
                  cp $f $out/lib/python${pythonMajorMinorVersion}/site-packages/$f;
                fi
              done
              popd
              mkdir $out/dist
              cp dist/${wheelName} $out/dist
              jq ".url = \"$out/dist/${wheelName}\"" $out/lib/python${pythonMajorMinorVersion}/site-packages/${pnameWithUnderscores}-${version}.dist-info/direct_url.json > temp.json && mv temp.json $out/lib/python${pythonMajorMinorVersion}/site-packages/${pnameWithUnderscores}-${version}.dist-info/direct_url.json
            '';

            meta = with pkgs.lib; {
              inherit description homepage license maintainers;
            };
          };
      in rec {
        defaultPackage = packages.default;
        devShells = rec {
          default = rydnr-sandbox-artifact-infrastructure-default;
          rydnr-sandbox-artifact-infrastructure-default =
            rydnr-sandbox-artifact-infrastructure-python311;
          rydnr-sandbox-artifact-infrastructure-python38 = shared.devShell-for {
            banner = "${
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python38
              }/bin/banner.sh";
            package = packages.rydnr-sandbox-artifact-infrastructure-python38;
            python = pkgs.python38;
            pythoneda-shared-pythoneda-banner =
              pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python38;
            pythoneda-shared-pythoneda-domain =
              pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python38;
            inherit archRole layer nixpkgsRelease org pkgs repo space;
          };
          rydnr-sandbox-artifact-infrastructure-python39 = shared.devShell-for {
            banner = "${
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python39
              }/bin/banner.sh";
            package = packages.rydnr-sandbox-artifact-infrastructure-python39;
            python = pkgs.python39;
            pythoneda-shared-pythoneda-banner =
              pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python39;
            pythoneda-shared-pythoneda-domain =
              pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python39;
            inherit archRole layer nixpkgsRelease org pkgs repo space;
          };
          rydnr-sandbox-artifact-infrastructure-python310 =
            shared.devShell-for {
              banner = "${
                  pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python310
                }/bin/banner.sh";
              package =
                packages.rydnr-sandbox-artifact-infrastructure-python310;
              python = pkgs.python310;
              pythoneda-shared-pythoneda-banner =
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python310;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python310;
              inherit archRole layer nixpkgsRelease org pkgs repo space;
            };
          rydnr-sandbox-artifact-infrastructure-python311 =
            shared.devShell-for {
              banner = "${
                  pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python311
                }/bin/banner.sh";
              package =
                packages.rydnr-sandbox-artifact-infrastructure-python311;
              python = pkgs.python311;
              pythoneda-shared-pythoneda-banner =
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python311;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python311;
              inherit archRole layer nixpkgsRelease org pkgs repo space;
            };
        };
        packages = rec {
          default = rydnr-sandbox-artifact-infrastructure-default;
          rydnr-sandbox-artifact-infrastructure-default =
            rydnr-sandbox-artifact-infrastructure-python311;
          rydnr-sandbox-artifact-infrastructure-python38 =
            rydnr-sandbox-artifact-infrastructure-for {
              python = pkgs.python38;
              pythoneda-shared-artifact-changes-events-infrastructure =
                pythoneda-shared-artifact-changes-events-infrastructure.packages.${system}.pythoneda-shared-artifact-changes-events-infrastructure-python38;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python38;
              rydnr-sandbox-artifact =
                rydnr-sandbox-artifact.packages.${system}.rydnr-sandbox-artifact-python38;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python38;
            };
          rydnr-sandbox-artifact-infrastructure-python39 =
            rydnr-sandbox-artifact-infrastructure-for {
              python = pkgs.python39;
              pythoneda-shared-artifact-changes-events-infrastructure =
                pythoneda-shared-artifact-changes-events-infrastructure.packages.${system}.pythoneda-shared-artifact-changes-events-infrastructure-python39;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python39;
              rydnr-sandbox-artifact =
                rydnr-sandbox-artifact.packages.${system}.rydnr-sandbox-artifact-python39;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python39;
            };
          rydnr-sandbox-artifact-infrastructure-python310 =
            rydnr-sandbox-artifact-infrastructure-for {
              python = pkgs.python310;
              pythoneda-shared-artifact-changes-events-infrastructure =
                pythoneda-shared-artifact-changes-events-infrastructure.packages.${system}.pythoneda-shared-artifact-changes-events-infrastructure-python310;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python310;
              rydnr-sandbox-artifact =
                rydnr-sandbox-artifact.packages.${system}.rydnr-sandbox-artifact-python310;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python310;
            };
          rydnr-sandbox-artifact-infrastructure-python311 =
            rydnr-sandbox-artifact-infrastructure-for {
              python = pkgs.python311;
              pythoneda-shared-artifact-changes-events-infrastructure =
                pythoneda-shared-artifact-changes-events-infrastructure.packages.${system}.pythoneda-shared-artifact-changes-events-infrastructure-python311;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python311;
              rydnr-sandbox-artifact =
                rydnr-sandbox-artifact.packages.${system}.rydnr-sandbox-artifact-python311;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python311;
            };
        };
      });
}
