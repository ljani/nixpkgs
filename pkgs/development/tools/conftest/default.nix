{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "conftest";
  version = "0.28.0";

  src = fetchFromGitHub {
    owner = "open-policy-agent";
    repo = "conftest";
    rev = "v${version}";
    sha256 = "1fb2i2pkpf0dv2g17zii68hkxk2ni6xn5xyrhb3gmkc6afz96ni0";
  };

  vendorSha256 = "sha256-jt1gQDtbZiBm5o5qwkRNeZDJJoRbXnRUcQ4GoTp+otc=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/open-policy-agent/conftest/internal/commands.version=${version}"
  ];

  HOME = "$TMPDIR";

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/conftest --version | grep ${version} > /dev/null
  '';

  meta = with lib; {
    description = "Write tests against structured configuration data";
    downloadPage = "https://github.com/open-policy-agent/conftest";
    homepage = "https://www.conftest.dev";
    license = licenses.asl20;
    longDescription = ''
      Conftest helps you write tests against structured configuration data.
      Using Conftest you can write tests for your Kubernetes configuration,
      Tekton pipeline definitions, Terraform code, Serverless configs or any
      other config files.

      Conftest uses the Rego language from Open Policy Agent for writing the
      assertions. You can read more about Rego in 'How do I write policies' in
      the Open Policy Agent documentation.
    '';
    maintainers = with maintainers; [ jk superherointj yurrriq ];
  };
}
