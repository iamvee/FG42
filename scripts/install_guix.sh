#! /usr/bin/env bash
set -eu
set -o pipefail

OUTPUTDIR=$1


bindir="${OUTPUTDIR}/bin"
guix_dir="${OUTPUTDIR}/mnt/guix"
guix_version="1.0.1"
arch="x86_64"
os="linux"
guix_url="https://ftp.gnu.org/gnu/guix/guix-binary-${guix_version}.${arch}-${os}.tar.xz"

mkdir -p "${bindir}"

mkdir -p "${guix_dir}"
pushd "${guix_dir}"
wget "${guix_url}"
tar --warning=no-timestamp -xf guix-*.xz
popd

# mv ${guix_dir}/gnu ${OUTPUTDIR}
# mv ${guix_dir}/var ${OUTPUTDIR}

pushd $guix_dir
guix_path=`find . -iname "guix" | grep bin | head -1`
guix_bin=$(dirname $guix_path | sed 's/^.//')

daemon_path=`find . -iname "guix-daemon" | grep bin | head -1`
daemon_bin=$(dirname $guix_path | sed 's/^.//')
popd

# local -r bash_bin=$(dirname `find "$OUTPUTDIR/gnu/store" -iname "bash" | grep bin | head -1`)

# echo "###"
# echo $bash_bin
# local -r guix_path=`find "$OUTPUTDIR/gnu/store" -iname "guix-daemon" | grep bin | head -1`
# local -r guix_bin=$(dirname $guix_path)

# ROOT_DIR=$OUTPUTDIR/root
# mkdir -p $ROOT_DIR/.config/guix/current

# ln -sf $OUTPUTDIR/var/guix/profiles/per-user/root/current-guix $ROOT_DIR/.config/guix/current
# ln -sf $bash_bin/bash $OUTPUTDIR/bin/bash
#$guix_dir/var/guix/profiles/per-user/$(whoami)/current-guix
#GUIX_PROFILE=$guix_dir/var/guix/profiles/per-user/$(whoami)/current-gui

#GUIX_PROFILE=$ROOT_DIR/.config/guix/current

export PATH="${bindir}:${guix_bin}:${PATH}"

{
    echo "#!/usr/bin/env bash"
    echo
    echo "proot -r ${guix_dir} -b /dev -b /proc -b /sys --root-id $guix_bin/guix \$@"
} > "${bindir}/guix"
chmod u+x "${bindir}/guix"

{
    echo "#!/usr/bin/env bash"
    echo
    echo "proot -R ${guix_dir} -w / -b /dev -b /proc -b /sys -b /tmp:/tmp --root-id $daemon_bin/guix-daemon --build-users-group=\$(whoami)"
    # /root/.config/guix/current/bin/guix-daemon --build-users-group=\$(whoami)
} > "${bindir}/guix-daemon"
chmod u+x "${bindir}/guix-daemon"

{
    echo "#!/usr/bin/env bash"
    echo
    echo "export PATH=${PATH}"
} > "${OUTPUTDIR}/profile"
