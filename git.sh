#!/bin/bash
GIT_SSH_COMMAND="ssh -i ~/.ssh/old/old -o IdentitiesOnly=yes" /usr/bin/git "$@"
