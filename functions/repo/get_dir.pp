function voxbolt::repo::get_dir (
  Target $repo,
) >> String[1] {
  "modules/${repo.vars['namespace']}/${repo.name}"
}
