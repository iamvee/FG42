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


mkdir -p root/.config/guix/
popd

pushd $guix_dir/root/.config/guix/
ln -sf ../../../../var/guix/profiles/per-user/root/current-guix ./current
popd

# Path related to rootfs
PROFILE_DIR=/root/.config/guix/current/

#GUIX_PROFILE=$guix_dir/var/guix/profiles/per-user/$(whoami)/current-gui

#GUIX_PROFILE=$ROOT_DIR/.config/guix/current

export PATH="${bindir}:${guix_bin}:${PATH}"

{
    echo "#!/usr/bin/env bash"
    echo
    echo "proot -R ${guix_dir} -w / -b /dev -b /proc -b /sys -b /tmp:/tmp --root-id $PROFILE_DIR/bin/guix \$@"
} > "${bindir}/guix"
chmod u+x "${bindir}/guix"

{
    echo "#!/usr/bin/env bash"
    echo
    echo 'echo $(whoami)'
    echo "proot -R ${guix_dir} -w / -b /dev -b /proc -b /sys -b /tmp:/tmp --root-id $PROFILE_DIR/bin/guix-daemon --build-users-group=\$(whoami) \$@"
} > "${bindir}/guix-daemon"
chmod u+x "${bindir}/guix-daemon"

{
    echo "#!/usr/bin/env bash"
    echo
    echo "export PATH=${PATH}"
} > "${OUTPUTDIR}/profile"
