workflow "Build" {
  on "push"
  resolves "Build"
}

action "Build" {
  uses = "singularityware/singularity:vault/release-2.6"
  runs = "build"
  args = "container.simg Singularity"
}

action "Run" {
  uses = "singularityware/singularity:vault/release-2.6"
  runs = "run"
  args = "$@"
}
