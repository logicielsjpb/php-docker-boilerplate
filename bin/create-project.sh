#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

if [ "$#" -ne 1 ]; then
    echo "No project type defined (either cms or neos)"
    exit 1
fi

rm -f "$TYPO3_DIR/.gitkeep"

case "$1" in
    ###################################
    ## TYPO3 CMS
    ###################################
    "cms")
        execInDir "$TYPO3_DIR" "composer create-project typo3/cms-base-distribution \"$TYPO3_DIR\""
        execInDir "$TYPO3_DIR" "touch FIRST_INSTALL"
        ;;

    ###################################
    ## TYPO3 NEOS
    ###################################
    "neos")
        execInDir "$TYPO3_DIR" "composer create-project typo3/neos-base-distribution \"$TYPO3_DIR\""
        ;;
esac

touch "$TYPO3_DIR/.gitkeep"