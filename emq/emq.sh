#!/bin/bash
# In The Name of God
# ========================================
# [] File Name : emq.sh
#
# [] Creation Date : 20-09-2018
#
# [] Created By : Parham Alvani <parham.alvani@gmail.com>
# =======================================
current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
        echo "usage: emq.sh <command>"
        echo "fetch     downloads and extracts EMQ binary release."
        echo "emqx      $current_dir/bin/emqx"
        echo "emqx_ctl  $current_dir/bin/emqx_ctl"
}

emq-download() {
        # emqx.zip is already exists
        if [ -f "$current_dir/emqx.zip" ]; then
                echo "$current_dir/emqx.zip is already exists, so skips the download phase."
                return 0
        fi

        # configuration
        local version="v3.0-beta.1"
        local os="ubuntu18.04"

        # download
        status=$(curl -# -w "%{http_code}" -o emqx.zip http://emqtt.io/static/brokers/emqx-$os-$version.zip || echo 500)
        if [ $status -ne 200 ]; then
                echo "$status"
                cat emqx.zip; rm emqx.zip
                return 1
        fi
        mv emqx.zip "$current_dir/emqx.zip"
        return 0
}

emq-extract() {
        if ! [ -x "$(command -v unzip)" ]; then
                echo 'unzip is not installed.'
                return 1
        fi

        if [ ! -f "$current_dir/emqx.zip" ]; then
                return 1
        fi

        if [ -d "$current_dir/emqx" ]; then
                echo "$current_dir/emqx directory is already exists, so skips the extract phase."
                return 0
        fi
        unzip "$current_dir/emqx.zip" -d $current_dir
        return 0
}

if [ -z $1 ]; then
        usage
        exit 1
fi
case $1 in
        fetch)
                emq-download
                emq-extract
                ;;
        emqx)
                shift
                $current_dir/emqx/bin/emqx $@
                ;;
        emqx_ctl)
                shift
                $current_dir/emqx/bin/emqx_ctl $@
                ;;
        *)
                usage
                exit
                ;;
esac
