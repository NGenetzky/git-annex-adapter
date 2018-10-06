docker run \
  -it --rm \
  --entrypoint /bin/bash \
  --volume "$(pwd):/usr/src/app:ro" \
  --volume "${HOME}/annex/ngenetzky-annex-a:/root/annex:ro" \
  git-annex-adapter

  # --user $(id -u)
