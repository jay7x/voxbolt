plan voxbolt::util::filter_repos (
  TargetSpec $targets,
  Optional[Pattern] $include = undef,
  Optional[Pattern] $exclude = undef,
) {
  $all_repos = $targets.get_targets

  $repos_1 = if $include {
    $all_repos.filter |$repo| { $repo.name =~ $include }
  } else { $all_repos }

  $repos_2 = if $exclude {
    $repos_1.filter |$repo| { $repo.name !~ $exclude }
  } else { $repos_1 }

  return $repos_2
}
