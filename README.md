# perivallon

Greek n. περιβάλλον • (perivállon) n (plural περιβάλλοντα), English "environment"

## Setup a new workstation

1. Accept Xocde license `sudo xcodebuild -license`
1. Clone this repo `$ git clone https://github.com/jbaskeen/perivallon.git && cd perivallon`
1. Run `./setup.sh -e your_github_email`

### Post install

#### iTerm2

Open iTerm2 Preferences and select the `custom` profile then select `Other Actions -> Set as Default` then delete the default profile. Next, in the `General` preferences tab select the following options from the `Preferences` section.

1. `Load Preferences from a custom folder or URL` -> `/Users/skeen/Library/Application Support/iTerm2/DynamicProfiles/`
1. `Saves changes to folder when iTerm2 quits`

Test the changes by quitting iTerm and restarting it.

#### tmux

Open iTerm2 and a new tmux session called `dev` should be loaded. Run prefix + `I` to run the install of the tmux plugins in the conf file. The session should be reloaded after the plugin install completes.

#### nvim

Open `neovim` and run `PluginInstall` to setup all the vim plugins.

#### Setup bash

```
$ sudo -s
$ echo /usr/local/bin/bash >> /etc/shells
$ chsh -s /usr/local/bin/bash
```

#### Chrome

(Optional) Start Chrome and sign in as your main user to import bookmarks and extensions automatically.
