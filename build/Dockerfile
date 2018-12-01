FROM singularityware/singularity:3.0

################################################################################
#
# Copyright (C) 2018 Vanessa Sochat.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public
# License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
################################################################################

# alpine image with the go tools

LABEL "com.github.actions.name"="Singularity 3.0"
LABEL "com.github.actions.description"="Singularity software as an action"
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://www.github.com/singularityhub/actions"
LABEL "homepage"="https://www.github.com/singularityhub/actions"
LABEL "maintainer"="Vanessa Sochat <vsochat@stanford.edu>"

# Environment variables to specify recipe, etc.
# Written to ${GITHUB_WORKSPACE}
ARG SINGULARITY_RECIPE=Singularity
ARG SINGULARITY_IMAGE="${GITHUB_SHA}.simg"

ADD entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
