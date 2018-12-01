workflow "Lint and Build" {
  on "push"
  resolves "Build"
}

action "Build" {
  uses = "singularityware/singularity:vault/release-2.6"
  args = "build container.simg Singularity"
}
