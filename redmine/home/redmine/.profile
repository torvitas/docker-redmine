# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes rvm bin if it exists
if [ -d "$HOME/.rvm/bin" ] ; then
  PATH="$PATH:$HOME/.rvm/bin"
fi

if [ -s "$HOME/.rvm/scripts/rvm" ] ; then
  source "$HOME/.rvm/scripts/rvm"
fi

if [ -s "$HOME/.rvm/scripts/completion" ] ; then
  source "$HOME/.rvm/scripts/completion"
fi

PATH="/home/redmine/.rvm/gems/ruby-2.1.4/bin:/home/redmine/.rvm/gems/ruby-2.1.4@global/bin:/home/redmine/.rvm/rubies/ruby-2.1.4/bin:/home/redmine/.rvm/bin:$PATH"
