# flake.nix
#
# This file packages pythoneda-sandbox-artifact/python-infrastructure as a Nix flake.
#
# Copyright (C) 2023-today rydnr's https://github.com/pythoneda-sandbox-artifact-def/python-infrastructure
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
  description =
    "Infrastructure layer for pythoneda-sandbox-artifact/python-artifact";
  inputs = rec {
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    nixos.url = "github:NixOS/nixpkgs/23.11";
    pythoneda-shared-artifact-events-infrastructure = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      inputs.pythoneda-shared-pythoneda-infrastructure.follows =
        "pythoneda-shared-pythoneda-infrastructure";
      url = "github:pythoneda-shared-artifact-def/events-infrastructure/0.0.11";
    };
    pythoneda-shared-pythoneda-banner = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      url = "github:pythoneda-shared-pythoneda-def/banner/0.0.38";
    };
    pythoneda-shared-pythoneda-domain = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      url = "github:pythoneda-shared-pythoneda-def/domain/0.0.15";
    };
    pythoneda-sandbox-artifact-python = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url = "github:pythoneda-sandbox-artifact-def/python/0.0.9";
    };
    pythoneda-shared-pythoneda-infrastructure = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixos.follows = "nixos";
      inputs.pythoneda-shared-pythoneda-banner.follows =
        "pythoneda-shared-pythoneda-banner";
      inputs.pythoneda-shared-pythoneda-domain.follows =
        "pythoneda-shared-pythoneda-domain";
      url = "github:pythoneda-shared-pythoneda-def/infrastructure/0.0.11";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        org = "pythoneda-sandbox-artifact";
        repo = "python-infrastructure";
        version = "0.0.7";
        sha256 = "1v1629i516gcvs6kbdp889221zd6fzvxypwlprd8ihvy1ff81jl6";
        pname = "${org}-${repo}";
        pythonpackage = "pythoneda.sandbox.artifact.infrastructure";
        pkgs = import nixos { inherit system; };
        description =
          "Infrastructure layer for pythoneda-sandbox/python-artifact";
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
        pythoneda-sandbox-artifact-python-infrastructure-for = { python
          , pythoneda-shared-artifact-events-infrastructure
          , pythoneda-shared-pythoneda-domain, pythoneda-sandbox-artifact-python
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
              pythonedaSharedArtifactEventsInfrastructure =
                pythoneda-shared-artifact-events-infrastructure.version;
              pythonedaSharedPythonedaDomain =
                pythoneda-shared-pythoneda-domain.version;
              pythonedaSharedPythonedaInfrastructure =
                pythoneda-shared-pythoneda-infrastructure.version;
              pythonedaSandboxArtifactPython =
                pythoneda-sandbox-artifact-python.version;
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
              pythoneda-shared-artifact-events-infrastructure
              pythoneda-shared-pythoneda-domain
              pythoneda-sandbox-artifact-python
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
          default = pythoneda-sandbox-artifact-python-infrastructure-default;
          pythoneda-sandbox-artifact-python-infrastructure-default =
            pythoneda-sandbox-artifact-python-infrastructure-python311;
          pythoneda-sandbox-artifact-python-infrastructure-python38 =
            shared.devShell-for {
              banner = "${
                  pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python38
                }/bin/banner.sh";
              extra-namespaces = "";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.pythoneda-sandbox-artifact-python-infrastructure-python38;
              python = pkgs.python38;
              pythoneda-shared-pythoneda-banner =
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python38;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python38;
              inherit archRole layer org pkgs repo space;
            };
          pythoneda-sandbox-artifact-python-infrastructure-python39 =
            shared.devShell-for {
              banner = "${
                  pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python39
                }/bin/banner.sh";
              extra-namespaces = "";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.pythoneda-sandbox-artifact-python-infrastructure-python39;
              python = pkgs.python39;
              pythoneda-shared-pythoneda-banner =
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python39;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python39;
              inherit archRole layer org pkgs repo space;
            };
          pythoneda-sandbox-artifact-python-infrastructure-python310 =
            shared.devShell-for {
              banner = "${
                  pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python310
                }/bin/banner.sh";
              extra-namespaces = "";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.pythoneda-sandbox-artifact-python-infrastructure-python310;
              python = pkgs.python310;
              pythoneda-shared-pythoneda-banner =
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python310;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python310;
              inherit archRole layer org pkgs repo space;
            };
          pythoneda-sandbox-artifact-python-infrastructure-python311 =
            shared.devShell-for {
              banner = "${
                  pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python311
                }/bin/banner.sh";
              extra-namespaces = "";
              nixpkgs-release = nixpkgsRelease;
              package =
                packages.pythoneda-sandbox-artifact-python-infrastructure-python311;
              python = pkgs.python311;
              pythoneda-shared-pythoneda-banner =
                pythoneda-shared-pythoneda-banner.packages.${system}.pythoneda-shared-pythoneda-banner-python311;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python311;
              inherit archRole layer org pkgs repo space;
            };
        };
        packages = rec {
          default = pythoneda-sandbox-artifact-python-infrastructure-default;
          pythoneda-sandbox-artifact-python-infrastructure-default =
            pythoneda-sandbox-artifact-python-infrastructure-python311;
          pythoneda-sandbox-artifact-python-infrastructure-python38 =
            pythoneda-sandbox-artifact-python-infrastructure-for {
              python = pkgs.python38;
              pythoneda-shared-artifact-events-infrastructure =
                pythoneda-shared-artifact-events-infrastructure.packages.${system}.pythoneda-shared-artifact-events-infrastructure-python38;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python38;
              pythoneda-sandbox-artifact-python =
                pythoneda-sandbox-artifact-python.packages.${system}.pythoneda-sandbox-artifact-python-python38;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python38;
            };
          pythoneda-sandbox-artifact-python-infrastructure-python39 =
            pythoneda-sandbox-artifact-python-infrastructure-for {
              python = pkgs.python39;
              pythoneda-shared-artifact-events-infrastructure =
                pythoneda-shared-artifact-events-infrastructure.packages.${system}.pythoneda-shared-artifact-events-infrastructure-python39;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python39;
              pythoneda-sandbox-artifact-python =
                pythoneda-sandbox-artifact-python.packages.${system}.pythoneda-sandbox-artifact-python-python39;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python39;
            };
          pythoneda-sandbox-artifact-python-infrastructure-python310 =
            pythoneda-sandbox-artifact-python-infrastructure-for {
              python = pkgs.python310;
              pythoneda-shared-artifact-events-infrastructure =
                pythoneda-shared-artifact-events-infrastructure.packages.${system}.pythoneda-shared-artifact-events-infrastructure-python310;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python310;
              pythoneda-sandbox-artifact-python =
                pythoneda-sandbox-artifact-python.packages.${system}.pythoneda-sandbox-artifact-python-python310;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python310;
            };
          pythoneda-sandbox-artifact-python-infrastructure-python311 =
            pythoneda-sandbox-artifact-python-infrastructure-for {
              python = pkgs.python311;
              pythoneda-shared-artifact-events-infrastructure =
                pythoneda-shared-artifact-events-infrastructure.packages.${system}.pythoneda-shared-artifact-events-infrastructure-python311;
              pythoneda-shared-pythoneda-domain =
                pythoneda-shared-pythoneda-domain.packages.${system}.pythoneda-shared-pythoneda-domain-python311;
              pythoneda-sandbox-artifact-python =
                pythoneda-sandbox-artifact-python.packages.${system}.pythoneda-sandbox-artifact-python-python311;
              pythoneda-shared-pythoneda-infrastructure =
                pythoneda-shared-pythoneda-infrastructure.packages.${system}.pythoneda-shared-pythoneda-infrastructure-python311;
            };
        };
      });
}
