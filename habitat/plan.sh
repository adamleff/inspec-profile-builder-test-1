pkg_name=inspec-profile-builder-test-1
pkg_version=0.1.0
pkg_origin=adamleff
pkg_deps=(chef/inspec core/ruby core/hab)
pkg_svc_user=root
pkg_license='Apache-2.0'


do_build() {
  cp -vr $PLAN_CONTEXT/../* $HAB_CACHE_SRC_PATH/$pkg_dirname
}

do_install() {
  local profile_contents
  local excludes
  profile_contents=($(ls))
  excludes=(habitat results *.hart)

  for item in ${excludes[@]}; do
    profile_contents=(${profile_contents[@]/$item/})
  done

  mkdir ${pkg_prefix}/dist
  cp -r ${profile_contents[@]} ${pkg_prefix}/dist/
}
