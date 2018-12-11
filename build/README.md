# Singularity Build Action

This is a simple test to clone the current Github repository inside a container
with Singularity, and then build the recipe at the root. This could be greatly 
improved if we could mount a volume, or copy files, or otherwise interact
with the runtime container outside of setting environment variables.

## How do I use this actions?

The repository name, `singularityhub/actions` is like a unique resource identifier (URI)
for the actions. We can extend that URI by adding a folder. Thus, to target this action,
for your Github repository, you might want to add something like this to your
`.github/main.workflow`:

```yml
action "Build" {
  uses = "singularityhub/actions/build@master"
  env = {
    SINGULARITY_RECIPE = "Singularity"
  }
}
```

By not setting any "args" we are using the default entrypoint as is. If you 
look at the [entrypoint.sh](entrypoint.sh) I've chosen to capture arguments
completely via the environment, this way I can set defaults in the Dockerfile.

## Environment Variables

| Variable           | Description                       | Default     |
|--------------------|-----------------------------------|-------------|
| SINGULARITY_RECIPE | Relative path to the build recipe | Singularity |
| SINGULARITY_IMAGE  | Name of the container image to build | ${GITHUB_SHA}.simg

Currently, the builder (installation of Singularity) lives inside the Docker 
container, and it builds your Singularity file in your repository by cloning
this repository internally.

I'll post an entire thing (the steps put together above) when I've tested and
have it somewhat working (insert "I have no idea what I'm doing" dog here!)

## What I learned

Every action has a URI that is based on the Github repository, with option
for subfolders. I would use each subfolder to have (minimally) A Dockerfile
and `entrypoint.sh` that uses it. Importantly, I'd want the Dockerfiles to
use the same base (docker) images. **Important!** Since the action builds the
container each time, try to bootstrap a base image from Docker Hub if you can.
