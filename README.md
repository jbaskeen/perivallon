# perivallon

Greek n. περιβάλλον • (perivállon) n (plural περιβάλλοντα), English "environment"

## Setup a new workstation

1. Accept Xocde license `sudo xcodebuild -license`
1. Clone this repo `$ git clone https://github.com/jbaskeen/perivallon.git && cd perivallon`
1. Run `./setup.sh -e your_github_email`

### Post install

#### iTerm2

Open iTerm2 Preferences and select the `custom` profile then select `Other Actions -> Set as Default`

Next, set the Powerline font: `Perferences -> Profiles -> Text` then under the `Font` select the checkbox `Use a different font for non-ASCII text`. In the Non-ASCII Font section select the powerline font `ProFont for Powerline`

#### Setup bash

```
$ sudo -s
$ echo /usr/local/bin/bash >> /etc/shells
$ chsh -s /usr/local/bin/bash
```
