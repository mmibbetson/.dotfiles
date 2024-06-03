# A lambda (λ) prompt.
# Green and red depending on exit status.
# Underlined if git status is dirty.
# Uppercase (Λ) if ahead of the remote.

function fish_prompt
  set_color blue
  echo -n (basename (pwd | sed "s#$HOME#\~#"))
  echo -n " "

  if is_git
    set_color yellow
    echo -n (git_branch)
    set_color normal
    echo -n " "
  end

  if is_status_okay
    set_color green
  else
    set_color red
  end

  if is_git_dirty
    set_color --underline
  end

  if is_git_ahead
    echo -n  "Λ"
  else
    echo -n  "λ"
  end

  set_color normal

  set jobs (job_count)
  if test $jobs -gt 0
    set_color magenta
    echo -n " %$jobs"
  end

  set_color normal
  echo -n " "
end
