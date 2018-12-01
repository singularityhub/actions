# Singularity Build Action

This is a simple test to clone the current Github repository inside a container
with Singularity, and then build the recipe at the root.

## How do I use this actions?

The repository name, `singularityhub/actions` is like a unique resource identifier (URI)
for the actions. We can extend that URI by adding a folder. Thus, to target this action,
for your Github repository, you might want to add something like this to your
`.github/main.workflow`:

```yml
action "Build" {
  uses = "singularityhub/actions/build@master"
  args = "Singularity"
}
```

We might also try it a bit differently - let's instead build the Builder,
and then run our own custom build with Singularity.
We can do this with someting like the following:

```yml
action "Create Builder" {
  uses = "actions/docker/cli@master"
  args = "build -f build/Dockerfile -t singularity-builder ."
}
```

This is creating a Docker container named "singularity-builder" from the Dockerfile in
the build directory.

```yml
action "Build" {
  needs ["Create Builder"]
  uses = "actions/docker/cli@master"
  args = "run -v $PWD:/data singularity-builder /data/Singularity"
}
```

The above is a little weird looking. It says "Use the `actions/docker/cli@master` 
(basically the command "docker"), but modify the entrypoint to be the `singularity`
executable, and bind the present working directory to data, and then tell the
container that the recipe is in `/data`. This entrypoint will build a container
named by "${GITHUB_SHA}.simg" so we can find it after (in the ${PWD})

Finally, to show that our container works, let's run it. This is again a little
weird, because an action is *required* to have a Docker container run it, we
are running Singularity through Docker.

```yml
action "Run" {
  needs ["Create Builder", "Build"]
  uses = "actions/docker/cli@master"
  args = "run --entrypoint singularity -v $PWD:/data singularity-builder run /data/${GITHUB_SHA}.simg"
}
```

This could use a lot of tweaking, but should be a start! In a nutshell, 
you need to [create a main workflow](https://developer.github.com/actions/creating-workflows/) 
that defines the steps for your repository to do on some trigger, like push. There 
are [several ways](https://help.github.com/articles/creating-a-workflow-with-github-actions/) to
do this, including using a visual editor, or via a text editor. Don't forgot the header
for the workflow that includes how to resolve it, for example this would say to run 
the above, resolving with "Run":

```yml
workflow "Build Singularity" {
  on "push"
  resolves "Run"
}
```

I'll post an entire thing (the steps put together above) when I've tested and
have it somewhat working.
