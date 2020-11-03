#!/bin/bash

source scripts/utils.sh echo -n

# Saner programming env: these switches turn some bugs into errors
set -o errexit -o pipefail

# This script is meant to be used with the command 'datalad run'

files_url=(
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/images_background.zip?raw=true images_background.zip" \
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/images_background_small1.zip?raw=true images_background_small1.zip" \
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/images_background_small2.zip?raw=true images_background_small2.zip" \
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/images_evaluation.zip?raw=true images_evaluation.zip" \
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/strokes_background.zip?raw=true strokes_background.zip" \
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/strokes_background_small1.zip?raw=true strokes_background_small1.zip" \
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/strokes_background_small2.zip?raw=true strokes_background_small2.zip" \
	"https://github.com/brendenlake/omniglot/blob/ceffff1ba059df9c19f12021b738dd1e0d8dd650/python/strokes_evaluation.zip?raw=true strokes_evaluation.zip")

# These urls require login cookies to download the file
git-annex addurl --fast -c annex.largefiles=anything --raw --batch --with-files <<EOF
$(for file_url in "${files_url[@]}" ; do echo "${file_url}" ; done)
EOF
git-annex get --fast -J8
git-annex migrate --fast -c annex.largefiles=anything *

md5sum *.zip > md5sums
