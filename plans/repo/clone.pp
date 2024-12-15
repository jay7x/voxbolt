# @summary Clone repos
#
# @param jobs
#   Run `git clone` in parallel (up to $jobs simultaneously)
#
plan voxbolt::repo::clone (
  TargetSpec $targets = 'voxpupuli',
  Integer $jobs = 1,
  Optional[Pattern] $include = undef,
  Optional[Pattern] $exclude = undef,
  Boolean $force = false,
) {
  $selected_repos = run_plan('voxbolt::util::filter_repos', targets => $targets, include => $include, exclude => $exclude)

  # Slice repos by $jobs into batches
  $clone_rs = $selected_repos.slice($jobs).reduce([]) |$memo, $batch| {
    # Clone all repos in the batch in parallel
    $memo + $batch.parallelize |$repo| {
      $repo_dir = voxbolt::repo::get_dir($repo)
      $repo_url = voxbolt::repo::get_url($repo)

      $cmd = (
        if $force {["test -d ${repo_dir} && rm -rf ${repo_dir};"] } else {[] }
        + ["git clone '${repo_url}' '${repo_dir}'"]
      ).join(' ')

      run_command($cmd, 'localhost', _catch_errors => true).first
    }
  }

  return ResultSet($clone_rs).error_set()
}
