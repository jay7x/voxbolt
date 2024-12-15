function voxbolt::repo::get_url (
  Target $repo,
) >> String[1] {
  "${repo.vars['git_base']}${repo.vars['namespace']}/${repo.name}"
}
