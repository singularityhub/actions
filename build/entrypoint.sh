#!/bin/sh -l

sh -c "echo $*"


USAGE="USAGE: entrypoint.sh Singularity"

# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

# CLONE ########################################################################
# We currently only do this until I figure out copy or volumes

# Clone the repository into the container
git clone "${GITHUB_REPOSITORY}" && \
    cd $(basename "${GITHUB_REPOSITORY}");

recipe="${1:-}"

if [ ! -f "${recipe}" ]
    then
    echo "Cannot find ${recipe}";
    exit 1;
fi

echo ""
echo "Image Recipe: ${recipe}"

# BUILD ########################################################################

/usr/local/bin/singularity build "${GITHUB_SHA}.simg" "${recipe}";
retval=$?

if [ $retval -eq 0 ];then
   echo "Singularity container ${GITHUB_SHA}.simg successfully built!"
fi

exit $retval
