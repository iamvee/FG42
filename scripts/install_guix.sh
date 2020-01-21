#! /usr/bin/env bash
set -eu
set -o pipefail

OUTPUTDIR=$1

function install_proot {
    local -r proot_url="http://static.proot.me/proot-x86_64"
    wget -O "$1/proot" "${proot_url}"
    chmod u+x "$1/proot"
}

function install_guix {
  local -r bindir="${OUTPUTDIR}/bin"
  local -r guix_dir="${OUTPUTDIR}/mnt/guix"
  local -r guix_version="1.0.1"
  local -r arch="x86_64"
  local -r os="linux"
  local -r guix_url="https://ftp.gnu.org/gnu/guix/guix-binary-${guix_version}.${arch}-${os}.tar.xz"
  mkdir -p "${bindir}"
  install_proot "${bindir}"

  mkdir -p "${guix_dir}"
  pushd "${guix_dir}"
  wget "${guix_url}"
  tar --warning=no-timestamp -xf guix-*.xz
  popd

  local -r guix_path=`find "$guix_dir/gnu/store" -iname "guix" | grep bin | head -1`
  local -r guix_bin=$(dirname $guix_path)

  ROOT_DIR=$OUTPUTDIR/root
  mkdir -p $ROOT_DIR/.config/guix/current

  ln -s $guix_dir/var/guix/profiles/per-user/root/current-guix $ROOT_DIR/.config/guix/current

  #$guix_dir/var/guix/profiles/per-user/$(whoami)/current-guix
  #GUIX_PROFILE=$guix_dir/var/guix/profiles/per-user/$(whoami)/current-gui

  GUIX_PROFILE=$ROOT_DIR/.config/guix/current

  export PATH="${bindir}:${guix_bin}:${PATH}"

  {
    echo "#!/usr/bin/env bash"
    echo
    echo "proot -b \"${guix_dir}/gnu:/gnu\" -b \"${ROOT_DIR}/:/root\" -b \"${guix_dir}/var/guix:/var/guix\" --root-id \$@"
  } > "${bindir}/runner"
  chmod u+x "${bindir}/runner"

  {
    echo "#!/usr/bin/env bash"
    echo
    echo "proot -b \"${guix_dir}/gnu:/gnu\" -b \"${ROOT_DIR}/:/root\" -b \"${guix_dir}/var/guix:/var/guix\" --root-id '$ROOT_DIR/.config/guix/current/bin/guix-daemon --build-users-group=\$(whoami)'"
  } > "${bindir}/fpkg-daemon"
  chmod u+x "${bindir}/fpkg-daemon"

  {
    echo "#!/usr/bin/env bash"
    echo
    echo "export PATH=${PATH}"
  } > "${OUTPUTDIR}/profile"

}

install_guix
