workflow "Build" {
  on = "push"
  resolves = "Build"
}

action "Build" {
  uses = "docker://singularityware/singularity:3.1.1-slim"
  args = "build container.sif Singularity"
}

action "Run" {
  uses = "docker://singularityware/singularity:3.1.1-slim"
  runs = "run"
  args = "$@"
}
