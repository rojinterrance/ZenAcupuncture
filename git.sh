#!/bin/bash
git filter-branch -f --commit-filter 'if [ "$GIT_AUTHOR_NAME" = "xxbinxx" ]; then export GIT_AUTHOR_NAME="Adi Singh"; export GIT_AUTHOR_EMAIL=adisin8@gmail.com;fi; git commit-tree "$@"'
git filter-branch -f --commit-filter 'if [ "$GIT_COMMITTER_NAME" = "xxbinxx" ]; then export GIT_COMMITTER_NAME="Adi Singh"; export GIT_COMMITTER_EMAIL=adisin8@gmail.com;fi; git commit-tree "$@"'
git log