
A good batch of applications to install first:

```bash
sudo pacman -Syu openssh git curl zsh neovim tmux firefox mosh
```

If you're using `i3` you may also want:

```bash
sudo pacman -Syu i3 i3status i3lock
```

To setup:

```bash
git clone git@github.com:Hoverbear/dotfiles.git
cd dotfiles
make nvim
make zsh
make tmux
make fonts
make i3
make i3lock
```

