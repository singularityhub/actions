#!/bin/sh -l

USAGE="USAGE: Set SINGULARITY_RECIPE and SINGULARITY_IMAGE envars."

# --- Option processing --------------------------------------------
if [ $# != 0 ] ; then
    echo $USAGE
    exit 1;
fi

# CLONE ########################################################################
# We currently only do this until I figure out copy or volumes

# The repository is located at ${GITHUB_WORKSPACE}
SINGULARITY_RECIPE="${GITHUB_WORKSPACE}/${SINGULARITY_RECIPE}"
SINGULARITY_IMAGE="${GITHUB_WORKSPACE}/${SINGULARITY_IMAGE}"

if [ ! -f "${SINGULARITY_RECIPE}" ]
    then
    echo "Cannot find ${SINGULARITY_RECIPE}";
    exit 1;
fi

echo ""
echo "Image Recipe: ${SINGULARITY_RECIPE}"

# BUILD ########################################################################

/usr/local/bin/singularity build "${SINGULARITY_IMAGE}" "${SINGULARITY_RECIPE}";
retval=$?

if [ $retval -eq 0 ];then
   echo "Singularity container ${SINGULARITY_IMAGE} successfully built!"
fi

# FIGURE OUT CONTAINER #########################################################

CONTAINEDBY=$(cat /etc/hostname)
echo "Container ID is ${CONTAINEDBY}"

exit $retval
