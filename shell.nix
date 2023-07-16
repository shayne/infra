{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    ansible
    deploy-rs
    terraform
    terranix

    nixpkgs-fmt
  ];
}
