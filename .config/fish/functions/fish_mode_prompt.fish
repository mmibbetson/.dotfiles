function fish_mode_prompt --description 'Displays the current mode'
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set_color red
        echo "Normal"
      case insert
        set_color green
        echo "Insert"
      case replace_one
        set_color green
        echo "Replace"
      case visual
        set_color brmagenta
        echo "Visual"
    end
    set_color normal
    printf " "
  end
end
