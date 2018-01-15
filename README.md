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

#### Setup bash

```
$ sudo -s
$ echo /usr/local/bin/bash >> /etc/shells
$ chsh -s /usr/local/bin/bash
```
