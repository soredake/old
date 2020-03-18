# Home (aka: user's dotfiles)

> These are my dotfiles. There are many like them, but these ones are mine.

![Screenshot of susekaboss’s shell prompt](http://example.com/ADDIT.jpg)

## Usage

* Clone this repo somewhere: `git clone https://github.com/fenque/home.git ~/Documents/github/home`
* To install run `./dotfiles.sh`
* To update the dotfiles run `git pull && ./dotfiles.sh`
* Alternatively, if you're setting up a fresh OS X install, use the `scripts/home.sh` script, which will set everything up and run all of the other scripts for you

## Customization

* In order to keep private info from public repos, use the `.bash/private` file; it's only copied by the `dotfiles.sh` script if it doesn't already exist
* It's also a place you can add extra private aliases, functions, etc.
* If you're maintaining a fork, run `git update-index --assume-unchanged` on this file in order to ignore the it's changes

## Additional scripts

The following scripts are available in the "scripts" folder:

* `atom.sh` Install Atom Editor packages
* `apt.sh` Install command-line tools using apt
* `home.sh` __Wrapper around the all of the other scripts; use this to set up a new Mac__
* `node.sh` Install global io.js packages
* `linux.sh` Sets up sensible defaults for OS X settings and a couple other cool tweaks
* `osx.sh` Sets up sensible defaults for OS X settings and a couple other cool tweaks
* `python.sh` Install global Python packages via Pip
* `ruby.sh` Install global ruby gems

## Help

* [Bash Alias cheat sheet](BASH.md)
* [Git Alias cheat sheet](GIT.md)

## Credits

Most of this was based on work by these awesome people:
* __Alex Weber https://github.com/alexweber/home__
* Mathias Bynens https://github.com/mathiasbynens/dotfiles
* Jan Moesen https://github.com/janmoesen/tilde
* Paul Irish https://github.com/paulirish/dotfiles
* Gianni Chiappetta https://github.com/gf3/dotfiles/tree/v1.0.0
* Cãtãlin Mariş  https://github.com/alrra/dotfiles
* Nicolas Gallagher  https://github.com/necolas/dotfiles
* Kevin Suttle https://github.com/kevinSuttle/dotfiles
* Ben Alman  https://github.com/cowboy/dotfiles
* Matijs Brinkhuis  https://github.com/matijs/dotfiles
