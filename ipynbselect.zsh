# ipynbselect

installed_dir=$(dirname $0)

function ipynbselect() {
  notebook_info=($(${installed_dir}/ipynbselect.py))
  if [ ${#notebook_info[@]} -eq 0 ]; then
    echo "server not found."
    return 1
  fi

  notebook_dir=${notebook_info[1]}
  port=${notebook_info[2]}

  notebook_file=$(
  find $notebook_dir -name "*.ipynb" | \
    grep -v ".ipynb_checkpoints" | \
    peco)
  notebook_file=${notebook_file#${notebook_dir}/*}

  notebook_url="http://localhost:${port}/tree/${notebook_file}"
  echo "${notebook_url}"
  python -m webbrowser -t "${notebook_url}"
}

# Local Variables:
# mode: Shell-Script
# End:
# vim: ft=zsh
