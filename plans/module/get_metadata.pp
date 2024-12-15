# @summary Return single module's metadata
#
# This plan uses stdlib's `loadjson` function to read and parse module's
# metadata.json
#
plan voxbolt::module::get_metadata (
  Target $target,
) {
  $repo_dir = voxbolt::repo::get_dir($target)
  return loadjson("${repo_dir}/metadata.json")
}
