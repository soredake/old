#!/bin/bash
# https://gist.github.com/rvl/c3f156e117e22a25f242
# http://blog.deadlypenguin.com/blog/2016/05/02/git-push-multiple-remotes/
git clone git@notabug.org:soredake/dotfiles_home.git "$HOME/git/dotfiles_home"
cd "$HOME/git/dotfiles_home" || exit
git push --set-upstream origin master
#git remote add github git@github.com:soredake/dotfiles_home.git
#git remote add gitlab git@gitlab.com:soredake/dotfiles_home.git
git remote set-url --add --push origin git@github.com:soredake/dotfiles_home.git
git remote set-url --add --push origin git@gitlab.com:soredake/dotfiles_home.git
git remote set-url --add --push origin git@notabug.org:soredake/dotfiles_home.git


git clone git@github.com:soredake/lutris-additions.git "$HOME/git/lutris-additions"
cd "$HOME/git/lutris-additions" || exit
git push --set-upstream origin master
git remote set-url --add --push origin git@notabug.org:soredake/lutris-additions.git
git remote set-url --add --push origin git@github.com:soredake/lutris-additions.git