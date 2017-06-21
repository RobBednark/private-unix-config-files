# Last updated: Fri 9/12/2002 06:15pm by Rob Bednark

# AUTHOR: Rob Bednark
################################################################################
### .bashrc
################################################################################

################################################################################
# oh-my-zsh BEGIN
################################################################################
enable_oh_my_zsh=false

HOSTNAME_COMPUTER_MOOVEL='mv-mbp13-rbednark'

if $enable_oh_my_zsh; then
    # Path to your oh-my-zsh configuration.
    ZSH=$HOME/.oh-my-zsh

    # Set name of the theme to load.
    # Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="robbyrussell"

    # Uncomment following line if you want red dots to be displayed while waiting for completion
    COMPLETION_WAITING_DOTS="true"

    # This should disable the title functionality in oh-my-zsh, but it is not
    # working for me.
    DISABLE_AUTO_TITLE='true'

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    plugins=(git)

    if echo $SHELL | grep zsh > /dev/null; then
        zsh_shell=true
        [ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
        # Disable hostname completion.  I thought this might have been causing a lockup I see when I attempt certain filename completions, but it doesn't.
        zstyle ':completion:*' hosts off
        # This allows completing something in the middle of a word (see http://stackoverflow.com/questions/13341900/zsh-how-do-i-set-autocomplete-so-that-it-inserts-the-completion-when-cursor-is )
        bindkey '^i' expand-or-complete-prefix
    fi
fi

################################################################################
# oh-my-zsh END
################################################################################

# Set the interactive shell prompt to [username@machinename directory]
if echo $SHELL | grep bash > /dev/null; then
    export PS1="\u@\h \w \D{%m/%d} \t\n$ "
fi
#
# e.g.,
# sara@LittleRed ~/bin Tue Oct 11 11:34:24$ 
#
if uname | grep Darwin  > /dev/null; then
    MacOSX=true
else
	alias	ls="ls -CF --color"
    MacOSX=false
fi

if hostname | grep -i atlatl > /dev/null; then
    Atlatl=true
else   
    Atlatl=false
fi

#export PS1="\u@\h \w \d \t$ "
#export PS1="$ "

if echo $SHELL | grep zsh > /dev/null; then
    # zsh prompt
    # %m - machine name; %d - current working directory; %@ - current time
    PS1='%m:%d %@ $ '
fi

# inc_append_history ==> Save every command before it is executed (this is different from bash's history -a solution):
# share_history ==> Retrieve the history file everytime history is called upon.
# append_history ==> If this is set, zsh sessions will append their history list to the history file, rather than replace it. Thus, multiple parallel zsh sessions will all have the new entries from their  history  lists added  to  the  history  file, in the order that they exit.

if type setopt > /dev/null 2>&1; then
    # Assert: this shell supports setopt (e.g., zsh)
    # When I start a new session, get the history of all sessions before it.  But once it's started, don't get any history from other sessions:
    setopt append_history no_inc_append_history no_share_history
else
    # bash
    # If this shell doesn't support setopt (like bash):
    # histappend => If the histappend shell option is enabled, the lines are appended to the history file, otherwise the history file is overwritten.
    shopt -s histappend
fi

# Show all lines of history, not just the last 15 lines.
alias hless="history|less"
alias htail="history|tail"

if type bindkey > /dev/null 2>&1; then
    # bind control-r to be the history search 
    bindkey '^R' history-incremental-search-backward
fi

# GIT_DIFF_OPTS -- set the number of lines of context to 0 lines
export GIT_DIFF_OPTS=-u0

export DISPLAY='rbednark:0.0'
export DISPLAY=""
export DISPLAY=":0.0"
export EDITOR="/usr/bin/vim"
# less -R ==> Like  -r,  but only ANSI "color" escape sequences are output in "raw" form.  Unlike -r, the screen appearance is maintained correctly in most cases.
# less --LINE_NUMBERS ==> enable line numbers
export LESS="-iRX --LINE-NUMBERS --jump-target=.5" # -R ==> process color escape sequences correctly   -i ==> case insensitive search, unless UPPERCASE chars are searched
                   # -X ==> do NOT clear the screen on exit  --jump-target=.5 ==> show matches in the middle of the screen instead of the first line
#export SHELL=/bin/bash
export VISUAL="/usr/bin/vim"
export SAVEHIST=80000 # max size in HISTFILE
if echo $SHELL | grep zsh > /dev/null; then
    # zsh
    # Added 2/8/13.  History was not getting saved on Atlatl Mac.  Not sure how it was getting saved on my Retina.
    alias history="history 1"  # by default, zsh history does not show entire history, so override and show all
    export HISTFILE=~/.zsh_history
    export HISTSIZE=32000 # max size internal history per session
else
    # bash
    export HISTSIZE=99999 # max size internal history per session
    export HISTFILESIZE=99999 # max size internal history per session
    #  HISTIGNORE
    #         A  colon-separated list of patterns used to decide which command lines should be saved on the history list.
    #         Each pattern is anchored at the beginning of the line and must match the complete line (no implicit `*'  is
    #         appended).   Each pattern is tested against the line after the checks specified by HISTCONTROL are applied.
    #         In addition to the normal shell pattern matching characters, `&' matches the previous  history  line.   `&'
    #         may  be escaped using a backslash; the backslash is removed before attempting a match.  The second and sub-
    #         sequent lines of a multi-line compound command are not tested, and are added to the history  regardless  of
    #         the value of HISTIGNORE.
    # & -- previous history line
    export HISTIGNORE="&:ls:[bf]g:exit:history"
fi
#export SHARE_HISTORY=1
# Uncommented APPEND_HISTORY 2/5/13
export APPEND_HISTORY=1 # Append rather than replace
#export INC_APPEND_HISTORY=1  
export HISTTIMEFORMAT="%m/%d/%y %a %T "

################################################################################
### Exports
################################################################################
export MANPATH="$MANPATH:/usr/man"
if $MacOSX; then
    # The path for the PostgreSQL Postgres.app from Heroku
    #export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
    #export PATH="$PATH:/Applications"
    :
fi
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/bin"
#export PATH="$PATH:/cygdrive/c/Program Files/Java/jdk1.5.0_02/bin"
#export PATH="$PATH:/home/sara/bin"
#export PATH="$PATH:/cygdrive/c/Program Files/MySQL/MySQL Server 5.5/bin"
export PATH="$PATH:~/bin"
if $MacOSX; then
    # Python3
    export PATH="$PATH:/usr/local/Cellar/python3/3.2.3/bin"
fi
export RCSINIT=" -zLT"  # RCSINIT - options that get prepended to rcs commands.  -z is to set the time zone.  LT is for local time.

## PYTHONPATH is searched by python for modules to import
#export PYTHONPATH="/fvt/tests/modules"
#export PYTHONPATH="~/selenium/selenium-python-client-driver-1.0.1"
##export PYTHONPATH="C:/cygwin/home/sara/selenium/selenium-python-client-driver-1.0.1"

if echo $OSTYPE | grep -i linux > /dev/null; then
	## ASSERT: this is Linux
	export PATH="$PATH:/usr/bin"
	export PATH="$PATH:/sbin"
	export PATH="$PATH:/usr/sbin"
	export PATH="$PATH:/home/sara/bin"
else
	:
fi

export AWS_ACCESS_KEY_ID='AKIAJME5CORBB3EJ3X5Q'
export AWS_SECRET_ACCESS_KEY='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'
export OSU_API_KEY='be0ebeaa7260905173375e8e26611192cf1c2c61'

################################################################################
### Non-exports:
################################################################################

### Directories dependent on one another, or used for Dir's down below

CmdDatestamp='date +%Y.%m.%d_%H.%M.%S.%a'
if hostname | grep 'littlered-ubuntu' > /dev/null; then
	DirSaraDocs="~/windows.sara.documents"
else
	DirSaraDocs="/cygdrive/c/Users/sara/Documents"
fi
IBM=false

if hostname | grep -i $HOSTNAME_COMPUTER_MOOVEL > /dev/null; then
    DirDropbox=~/dropbox.symlink
else
    DirDropbox=~/Dropbox
fi
DirGit=$DirDropbox/git
DirGitLocal="$HOME/local.git"
DirRob="$DirSaraDocs/Rob"
# This is what it was on HOME-PC desktop:
#DirRbednark="/cygdrive/c/cygwin/home/sara"
DirRbednark=~
DirTopPC="$HOME"
DirTopUnix="/home/rbednark"
DirBin="$DirDropbox/bin"
DirTxt="$DirTopPC/txt"
DirDoc=$DirDropbox/Rob/doc

DirAddToQuizme="$DirDropbox/add_to_quizme"
DirBackup="$DirTopPC/backup"
DirBednarkCom="$DirDropbox/Rob/bednark.com"
DirC="/cygdrive/c"
DirCheckin="$DirRbednark/checkin"
DirDownload="$DirRbednark/download"
DirFamilyTree="$DirDropbox/family.tree/docs.July.1.Fri"
DirGithub=~/git
if $MacOSX; then
    DirIphoneApps="~/Music/iTunes/iTunes Media/Mobile?Applications"
fi
DirLearn="$DirBin/learn"
DirOptionTables="$DirRbednark/option.tables"
DirPicts="$DirRbednark/picts"
DirPublicHtml="$DirRbednark/public_html"
DirResume="$DirDropbox/rob.resume"
DirQuiz="$DirLearn/quiz.python/db"
DirQuizMe=$DirGit/quizme_website
DirReadOnly="$DirRbednark/read.only"
DirSync="$DirRbednark/sync"
DirUnixConfigFiles="$DirDropbox/Rob/unix.config.files"

BinQuote="$DirBin/get.random.quote.pl"

FileAbout="$DirBednarkCom/cpp/aboutMe.cpp"
FileAccomplishments="$DirDoc/accomplishments.txt"
FileBlog="$DirDoc/blog.txt"
FileBlogHtml="$DirBednarkCom/cpp/blog.cpp"
FileBooknotes="$DirBednarkCom/cpp/bookNotes.cpp"
FileContactInfo="$DirBednarkCom/cpp/contact.info.cpp"
FileDiary="$DirDoc/diary.txt"
FileDoc="$DirDoc/doc.txt"
FileEmailAddrs="$DirDoc/aliases.text"
FileEstimates="$DirDoc/estimates.txt"
FileEmailGroups="$DirBednarkCom/cpp/email.groups.cpp"
FileFamilyTreeHtml="$DirDropbox/family.tree/Html/I1.html"
FileHuawei="$DirDoc/huawei.notes.txt"
FileHumor="$DirBednarkCom/cpp/humor.cpp"
FileIndex="$DirBednarkCom/cpp/index.cpp"
FileInformixEmployees="$DirPublicHtml/employees.html"
FileJ="$DirDoc/j.txt"
FileJQuizCopy="$DirQuiz/j.txt"
FileJTmp="$DirDoc/j.interim.txt"
FileJTmpQuizCopy="$DirQuiz/j.interim.txt"
FileLearnTodo="$DirQuiz/db_want_to_learn_find_out_get_answers_ask_google_helpouts_stackoverflow_todo.txt"
FileMyPsychology="$DirDoc/my.psychology.txt"
if hostname | grep 'littlered-ubuntu' > /dev/null; then
	DirCygwin="~/windows.cygwin.home.sara"
	#FileRc="$DirCygwin/.bashrc"
	FileRc="$DirUnixConfigFiles/.bashrc"
else
	FileRc="$DirUnixConfigFiles/.bashrc"
fi
FilePeopleHtml="$DirBednarkCom/people.I.know.html"
FilePeopleTxt="$DirDoc/people.I.know.txt"
FilePhone="$DirDoc/phone.nums.txt"
FilePicts="$DirTxt/sent.list.txt"
FilePingOutput=~/tmp/ping.monitor.$$
FilePingSymlinkActive=~/tmp/ping.monitor.active
FileQuotes="$DirBednarkCom/quotes.html"
FileRecommendations="$DirBednarkCom/cpp/i.recommend.cpp"
FileSitemap="$DirBednarkCom/sitemap.xml"
FileViolinStrings="$DirBednarkCom/cpp/violin.strings.survey.cpp"
FileSiteMapHtml="$DirBednarkCom/cpp/site.map.cpp"
FileSiteMapXml="$DirBednarkCom/sitemap.xml"
FileSoftwareQuotes="$DirBednarkCom/cpp/software.quotes.cpp"
FileStocks="$DirDoc/sto.txt"
FileStockNotes="$DirDoc/stock.notes.txt"
FileStories="$DirBednarkCom/cpp/stories.cpp"
FileToday="$DirDoc/today.txt"
FileTodayNew="$DirBin/todo_db.py"
FileToDo="$DirDoc/todo.txt"
FileVimrc="$DirUnixConfigFiles/.vimrc"
FileVocab="$DirBednarkCom/cpp/vocab.cpp"

################################################################################
### Atlatl 
################################################################################
# alias   cd.atlatl.mvp.from.creo="cd $DirDropbox/git/atlatl-mvp/atlatl-server"
# alias   cd.atlatl.core="cd $DirDropbox/git/dart-core/atlatl-server"
# alias   cdtest="cd $DirDropbox/git/dart-core/acceptance-tests/cuke-atlatl"
# alias   show_data="python -u manage.py show_data |& less"
# alias   ssh.dev.app="ssh -i ~/.ssh/DEVapp.pem rbednark@devapp.atlatlprivate.com"
# alias   ssh.dev.db="ssh -i ~/.ssh/DEVdb.pem masteradmin@devdb.atlatlprivate.com"
# alias   ssh.dev.web="ssh -i ~/.ssh/DEVweb.pem rbednark@devweb.atlatlprivate.com"
# alias   ssh.prod.app="ssh -i ~/.ssh/PRODapp1.pem rbednark@prodapp1.atlatlprivate.com"
# alias   ssh.prod.db="ssh -i ~/.ssh/PRODdb1.pem rbednark@proddb1.atlatlprivate.com"
# alias   ssh.prod.web="ssh -i ~/.ssh/PRODweb1.pem rbednark@prodweb1.atlatlprivate.com"
#alias   atlatl.run.unit.tests="cdcore; workon atlatl; (./manage.py test --testrunner=django.test.simple.DjangoTestSuiteRunner --settings=unit_test_settings main organization account quote rest_api customer lockout configuration api)"
#alias   atlatl.run.unit.tests="cdcore; python -u manage.py test --testrunner=django.test.simple.DjangoTestSuiteRunner --settings=unit_test_settings main organization account quote rest_api customer lockout configuration api"
# alias   atlatl.run.unit.tests="cdcore; python -u manage.py test --testrunner=django.test.simple.DjangoTestSuiteRunner --settings=unit_test_settings account api configuration customer freight main native organization poc quote rest_api lockout"
# alias   atlatl.coverage="coverage run atlatl-server/manage.py test account api configuration customer freight main native organization poc quote rest_api lockout --settings=unit_test_settings"
#function   atlatl.recreate.db.only() {
#    cdcore
#    find . -name '*.pyc' -delete
#    dropdb -U atlatl atlatl
#    if createdb -U atlatl atlatl; then
#        time ./manage.py syncdb --migrate --noinput
#        return 0
#    else
#        echo "ERROR from createdb; see above"
#        return 1
#    fi
#}
#function   atlatl.recreate.db.only2() {
#    find . -name '*.pyc' -delete
#    dropdb -U atlatl atlatl2
#    if createdb -U atlatl atlatl2; then
#        time ./manage.py syncdb --migrate --noinput
#        return 0
#    else
#        echo "ERROR from createdb; see above"
#        return 1
#    fi
#}
#function atlatl.create.db.data() {
#    time ./manage.py make_test_data --email-domain=bednark.com --num-clients=1 --num-levels=0 --num-configs=1 --num-parts=1 --num-quotes=1 --num-sub-orgs=0 --num-users=1
#}
#function   atlatl.recreate.db.data.and.runserver() {
#    start=$(date)
#    if atlatl.recreate.db.only; then
#        atlatl.create.db.data
#        ./manage.py runserver
#    fi
#}
#function   atlatl.recreate.db.data.and.runserver2() {
#    start=$(date)
#    if atlatl.recreate.db.only2; then
#        atlatl.create.db.data
#        ./manage.py runserver 8002
#    fi
#}
#function atlatl.curl.wirecrafters.login() {
#    (
#    curl --verbose --data 'email=wc.sales.rep@bednark.com&password=p' http://wirecrafters.dev.atlatlprivate.com/api/account/login/
#    )
#}
################################################################################
### Aliases
################################################################################
#alias acrobat="'/cygdrive/c/Program Files/Adobe/Acrobat 6.0/Reader/AcroRd32.exe'"
#alias acrobat="'/cygdrive/c/Program Files/Adobe/Acrobat 7.0/Reader/AcroRd32.exe'"
#alias acrobat="'/cygdrive/c/Program Files (x86)/Adobe/Reader 10.0/Reader/AcroRd32.exe'"

if $MacOSX; then
    alias open.adobe.reader='open -a "Adobe Reader"'
fi

alias   browse.family.tree="firefoxfile $FileFamilyTreeHtml"

alias	cdbednarkcom="cd $DirBednarkCom"
alias   cdbuddyup="cd $DirGitLocal/buddyup.github.adevore"
alias   cddada="cd $DirDropbox/Rob/dada"
alias   cd.iphone.apps="cd ~/Music/iTunes/iTunes?Media/Mobile?Applications"
alias   cddockerlearn="cd $DirDropbox/bin/learn/dir-learn-docker"
alias   cddockercomposelearn="cd $DirDropbox/bin/learn/dir-learn-docker-compose"
alias   cddjango="cd $DirDropbox/bin/learn/dir.learn.django.projects"
alias   cddjangocode="cd /home/sara/local.dir.learn.django.projects/my.venv/lib/python2.7/site-packages/django"
alias	cddoc="cd $DirDoc"
alias	cddownload="cd $DirDownload"
alias   cddropbox="cd $DirDropbox"
alias   cdfam="cd $DirDropbox/family.tree/docs.July.1.Fri"
alias   cdgit="cd $DirGit"
alias   cdisbullshit="cd $DirGitLocal/isbullshit-crawler"
alias	cdlearn="title learn; cd $DirLearn"
alias   cdlearngit="cd $DirLearn/git"
#alias	cdmusic="cd /cygdrive/c/Documents\ and\ Settings/All\ Users/Documents/My\ Music/"
#alias	cdoption="cd $DirOptionTables"
alias   cdosqa="cd $DirGitLocal/osqa"
alias   cdosu="cd $DirGit/osu-game-stats-top-10k-players; workon osu-game-stats-top-10k-players"
alias	cdpicts="cd $DirPicts"
alias   cdpsu="cd $DirDropbox/Rob/psu.online.map"
alias	cdpublic="cd $DirPublicHtml"
alias   cdpydoc="cd $DirDropbox/Rob/python.doc/python-2.7.2-docs-text"
alias   cdquantopian="cd $DirDropbox/quantopian"
alias   cdquiz="title quiz; cd $DirQuiz"
alias   cdquizme="cd $DirQuizMe; workon quizme"
alias   cdresume="cd $DirResume"
alias   cdscrapy="cd $DirLearn/scrapy"
#alias	cdsel="title ebento.py; cd ~/huawei/selenium"
#alias	cdstax="cd $DirLearn/stax; pwd; ls"
alias   cdstatements="cd $DirDropbox/Statements.and.bills"
alias   cdsurvey="cd $DirDropbox/mike.ames.survey/"
alias	cdsync="cd $DirSync"
#alias	cdtestadm="cd $DirTestadm; ls"
alias	cdtxt="cd $DirTxt"
alias   cdunixconfigfiles="cd $DirUnixConfigFiles"
alias   cdvagrant="cd ~/Desktop/vagranttest"
#alias   cdvim="cd '/cygdrive/c/Program Files (x86)/Vim/vim72/doc'"

################################################################################
# Moovel:
################################################################################
DirMoovel=$DirDropbox/moovel
DirReposMoovel="~/repos"
DirReposMoovelDevops="~/repos.devops"
DirReposMoovelDocker="$DirReposMoovel/na-transitutils-docker/src/app"
DirReposMoovelClients="~/repos.clients"
alias   cdmoovel="cd $DirMoovel"

alias   cddocker="cd $DirReposMoovel/na-transitutils-docker"
alias   cdgamma="cd $DirReposMoovel/gamma-docker"
alias   cdgateway="cd $DirReposMoovelDocker/na-gateway-python"
alias   cdgtfs="cd $DirReposMoovelDocker/na-gtfs-py"
alias   cdingestion="cd $DirReposMoovelDocker/na-ingestionserver-python"
alias   cdmobility="cd $DirReposMoovelDocker/na-mobility-python"
alias   cdproviders="cd $DirReposMoovelDocker/na-providers-python"
alias   cdrrrr="cd $DirReposMoovelDocker/rrrr"
alias   cdtest="cd $DirReposMoovelDocker/na-trip-utils-api-tests"
alias   cdtransit="cd $DirReposMoovelDocker/na-transitplusplus-python"

alias   cdtrip-planner="cd $DirReposMoovel/trip-planner"

alias   cdenv-shared-prod-east="cd $DirReposMoovelDevops/env-shared-prod-east"
alias   cdenv-shared-dev="cd $DirReposMoovelDevops/env-shared-dev"

alias   cdandroid="cd $DirReposMoovelClients/na-ridetap-android"
alias   cdios="cd $DirReposMoovelClients/na-ridetap-ios"
alias   cdthe.app.factory="cd $DirReposMoovelClients/the-app-factory"

alias   addrs.dev="$DirLearn/parse_moovel_instances.py"
alias   psql.ridescout.providers="psql -h ridescoutgeo.cixz9hxezij4.us-west-2.rds.amazonaws.com -U ridescout -W providers"
alias   ssh.rs.mobility="ssh ubuntu@beta.mobility.ridescout.com -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
alias   ssh.rs.providers="ssh ubuntu@52.27.32.0 -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
alias   ssh.rs.gateway="ssh ubuntu@54.191.144.62 -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
# alias   ssh.rs.transit="ssh ubuntu@54.191.119.117 -i ~/repos/na-providers-python/ridescout-backend-developer.pem.txt"
alias   ssh.rs.ingestion="ssh ubuntu@ec2-52-88-39-172.us-west-2.compute.amazonaws.com -i $DirMoovel/certs/ridescoutingestion.pem"
alias   ssh.rs.transit="ssh ubuntu@ec2-54-191-119-117.us-west-2.compute.amazonaws.com -i $DirMoovel/certs/ridescoutingestion.pem"
alias   scp.jump.server="~/repos.devops/it/aws/tools/vpc-tunnel.sh development 172.18.1.21 9998; sleep 1.5; scp -P 9998 127.0.0.1:myfile ."
alias   ssh.jump.server="~/repos.devops/it/aws/tools/vpc-tunnel.sh development 172.18.1.21 9998; sleep 1.5; ssh -p 9998 127.0.0.1"
moovel_prod="https://rs-gateway.transitsherpa.com"
moovel_shared_dev="https://rs-gateway-dev.gslabs.us"
coords_san_antonio='lat=29.42&lng=-98.48'
alias curl.ridesnear.local.octa='curl "http://0.0.0.0:48002/city/rides-near/?lat=33.699841&lng=-117.759218&api_key=backendrules&format=json&limit=3&presentation_demo=true"'
alias curl.busstops.shareddev.san_antonio='curl "https://rs-gateway-dev.gslabs.us/transit/bus-stops/?api_key=backendrules&lat=29.414695&lng=-98.436579&radius=2000&end=29.414695,-98.436579" | json_pp | less'
alias curl.ridesnear.shareddev.octa='curl "https://rs-gateway-dev.gslabs.us/city/rides-near/?lat=33.699841&lng=-117.759218&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.prod.octa.at.zipcar='curl "https://rs-gateway.transitsherpa.com/city/rides-near/?lat=33.672080695117245&lng=-117.84223858968812&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.shareddev.octa.at.zipcar='curl "https://rs-gateway-dev.gslabs.us/city/rides-near/?lat=33.672080695117245&lng=-117.84223858968812&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.shareddev.portland='curl "https://rs-gateway-dev.gslabs.us/city/rides-near/?lat=45.5199&lng=-122.6799&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.providersnear.prod.portland='curl "https://rs-gateway.transitsherpa.com/city/providers-near/?radius=3000&lat=45.5199&lng=-122.6799&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.providersnear.shareddev.portland='curl "https://rs-gateway-dev.gslabs.us/city/providers-near/?radius=3000&lat=45.5199&lng=-122.6799&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.providersnear.shareddev.octa='curl "https://rs-gateway-dev.gslabs.us/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=33.683947&format=json&lng=-117.794694" | json_pp | less'
alias curl.providersnear.prod.octa='curl "https://rs-gateway.transitsherpa.com/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=33.683947&format=json&lng=-117.794694" | json_pp | less'
alias curl.providersnear.prod.san-antonio='curl "https://rs-gateway.transitsherpa.com/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=29.42&format=json&lng=-98.48" | json_pp | less'
alias curl.providersnear.shared-dev.san-antonio='curl "https://rs-gateway-dev.gslabs.us/city/providers-near/?api_key=7e03125622b5d4c262d1c02012e9f200&radius=3000&presentation_demo=true&lat=29.42&format=json&lng=-98.48" | json_pp | less'
alias curl.ridesnear.shared-dev.san-antonio='curl "${moovel_shared_dev}/city/rides-near/?${coords_san_antonio}&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.ridesnear.prod.san-antonio='curl "${moovel_prod}/city/rides-near/?${coords_san_antonio}&api_key=backendrules&format=json&limit=3&presentation_demo=true" | json_pp | less'
alias curl.instances.shareddev.raw='curl "https://dashboard-shared-dev.gslabs.us/gamma-status/instances"'
alias curl.instances.shareddev='curl "https://dashboard-shared-dev.gslabs.us/gamma-status/instances" | json_pp | less'
################################################################################
# Idealist:
################################################################################
# DirIdealistRepos="~/work/repos"

# alias   cdhvap="cd $DirIdealistRepos/app-hvap"
# alias   cdi3="cd $DirIdealistRepos/app-ido-i3"
# alias   cdi3.osx="cd ~/idealist/repos/app-ido-i3-OSX"
# alias   cdidealist="cd $DirDropbox/Rob/idealist"
# alias   cdsysutils="cd $DirIdealistRepos/sys-utils"
# alias   cdtechnical-design-docs="cd $DirIdealistRepos/technical-design-docs"
# alias   idealist.coverage="coverage report --show-missing --rcfile=.coveragerc-api"
# alias   idealist.psql.sandbox="psql -h pgsandbox.dev.awb -U i3"
# alias   idealist.scp.depot.webapp.log='dir=~/tmp/api.logs/depot/c768; mkdir -p $dir; scp depot.awbdev.org:/awb/logs/app/lomo/c768/webapp.log $dir'
# alias   idealist.scp.lomo.webhead.api.logs='for webhead in $(grep "^lomo-webheads" ~/work/repos/sys-utils/conf/csshrc |sed -e "s/^lomo-webheads = //"); do echo $webhead ; mkdir -p ~/tmp/api.logs/ido-c768/$webhead; scp -p $webhead:/idealist/var/instance/ido-c768/api-*.log ~/tmp/api.logs/ido-c768/$webhead; done'
# alias   idealist.ssh.pgsandbox0="ssh command@pgsandbox0.dev.awb"
# alias   idealist.ssh.pgsandbox1="ssh command@pgsandbox1.dev.awb"
# alias   idealist.ssh.pgsandbox2="ssh command@pgsandbox2.dev.awb"
# alias   sub="ssh ubuntu"

################################################################################
# Trapit:
################################################################################
#DirTrapit="~/trapit"
#DirTrapitRepos="~/trapit.repos"

#alias   ab0="ssh a-build-0"
#alias   a-build-0="ssh a-build-0"

#alias   cdarcher="cd $DirTrapitRepos/archer"
#alias   cdansible="cd $DirTrapitRepos/ansible"
#alias   cdarsenal="cd $DirTrapitRepos/arsenal"
#alias   cddocumentation="cd $DirTrapitRepos/documentation"
#alias   cddocumentation.wiki.git="cd $DirTrapitRepos/documentation.wiki.git"
#alias   cdelzar="cd $DirTrapitRepos/elzar; title elzar"
#alias   cdfigure="cd $DirTrapitRepos/figure"
#alias   cdgoose="cd $DirTrapitRepos/python-goose"
#alias   cdgoose.grangier="cd $DirTrapitRepos/grangier.goose"
#alias   cdlogparser="title logparser; cd $DirTrapitRepos/logparser"
#alias   cdlogster="title logster; cd $DirTrapitRepos/logster"
#alias   cdmisc="cd $DirTrapitRepos/misc/rbednark/docs"
#alias   cdmom="cd $DirTrapitRepos/mom; title mom"
#alias   cdmorbo="cd $DirTrapitRepos/morbo; title morbo"
#alias   cdnibbler="cd $DirTrapitRepos/nibbler"
#alias   cdnova="cd $DirTrapRepos/nova"
#alias   cdops="cd $DirTrapitRepos/ops"
#alias   cdpenrose="cd $DirTrapitRepos/penrose"
#alias   cdpolaris="cd $DirTrapitRepos/polaris"
#alias   cdqueuestore="cd $DirTrapitRepos/queuestore"
#alias   cdresearch="cd $DirTrapitRepos/research"
#alias   cdredbike="cd $DirTrapitRepos/lukearno.redbike"
#alias   cdrosecity="cd $DirTrapitRepos/rosecity; title rosecity"
#alias   cdrunlog="cd $DirTrapitRepos/runlog"
#alias   cdselector="title selector; cd $DirTrapitRepos/lukearno.selector"
#alias   cdshortlinks="cd $DirTrapitRepos/shortlinks"
#alias   cdstorytool="cd $DirTrapitRepos/storytool"
#alias   cdsupport="cd $DirTrapitRepos/support"
#alias   cdthedude="cd $DirTrapitRepos/thedude"
#alias   cdtachyon="cd $DirTrapitRepos/tachyon"
#alias   cdtenjintemplates="cd $DirTrapitRepos/tenjintemplates"
#alias   cdtrapit.vagrant="cd ~/vagrants/trapit.hashicorp.precise64" # trapit
#alias   cdtrapit.repos="cd ~/vagrants/trapit.hashicorp.precise64/trapit.repos" # trapit
#alias   cdval="cd $DirTrapitRepos/val"
#alias   cdvulcan="cd $DirTrapitRepos/vulcan"
#alias   cdwalter="cd $DirTrapitRepos/walter"
#alias   cdwordpressplugin="cd $DirTrapitRepos/wordpress-plugin"
#alias   cdyaro="cd $DirTrapitRepos/yaro-0.6.4"
#alias   cdzapper="cd $DirTrapitRepos/zapper"
#alias   cdzoidberg="cd $DirTrapitRepos/zoidberg"
#alias   cdzulu="cd $DirTrapitRepos/zulu"

#alias   higgs=trapit.psql.higgs

#alias   redis.higgs.cache="redis-cli -h 10.0.1.101 -p 6379"
#alias   redis.higgs.events="redis-cli -h 10.0.1.101 -p 6379 -d 1"
#alias   redis.higgs.landing-page-cache="redis-cli -h 10.0.1.55 -p 3344 -d 0"
#alias   redis.higgs.memory="redis-cli -h 10.0.1.101 -p 6379 -d 0"
#alias   redis.higgs.nibbler="redis-cli -h 10.0.1.101 -p 6379 -d 0"
#alias   redis.higgs.queuecache="redis-cli -h 10.0.1.55 -p 6381 -d 0"
#alias   redis.higgs.quickcheck="redis-cli -h 10.0.1.55 -p 6381 -d 0"
#alias   redis.higgs.redbike="redis-cli -h 10.0.1.101 -p 6379 -d 0"
#alias   redis.higgs.runlog="redis-cli -h 10.0.1.55 -p 6380 -d 0"
#alias   redis.higgs.shorts="redis-cli -h 10.0.1.81 -p 6379 -d 0"
#alias   redis.higgs.url_hash="redis-cli -h 10.0.1.55 -p 6382 -d 0"
#alias   redis.higgs.zb1="redis-cli -h 10.0.1.151 -p 6379 -d 0"
#alias   redis.higgs.zoidberg="redis-cli -h 10.0.1.55 -p 6378 -d 0"

#alias   ssh.trapit="cdtrapit.vagrant; vagrant up; vagrant ssh"
#alias   stag="ssh staging-1"
#alias   st="ssh staging-1"

#alias   trapit.cp.fusion.metric.scripts="(DIR_FUSION=$DirTrapitRepos/xm-2.fusion.metrics; mkdir -p $DIR_FUSION; scp -p 'xm-2:/home/fusion/metrics/*.{py,sh}' $DIR_FUSION)"
#alias   trapit.psql.astro="psql -h 10.23.1.21 -U zoidberg --password trapit"
##alias   trapit.psql.deloitte="psql -h 10.23.1.21 -U zoidberg -W trapit"
#alias   trapit.psql.higgs="psql -h 10.0.1.24 --username=zoidberg --dbname=trapit"
#alias   trapit.psql.higgs.db-3="psql -h 10.0.1.22 --username=zoidberg -W --dbname=trapit"
#alias   trapit.psql.logs="psql -h 10.0.5.222 --username=zoidberg -W --dbname=trapit_nginx_logs"
#alias   trapit.psql.staging="psql --host=10.0.1.94 --username=zoidberg --dbname=trapit"  # Need to be on staging
#alias   trapit.scp.deloitte.logs="mkdir -p /tmp/nginx-logs/deloitte; date; time scp -Cpr deloitte:/trapit/logs-archive/rsync-var-log-trapit/trapit/'*.gz' /tmp/nginx-logs/deloitte; date"

#alias   vgoogleplus="vici $DirTrapit/google.plus.design.notes.md"
#alias   virt="source .virt/bin/activate"
#alias   vtrapitfaq="title Trapit FAQ; vici $DirTrapitRepos/misc/rbednark/docs/faq_platform.md"
#alias   vtrapitdiaries="title Trapit diaries; vim $DirTrapitRepos/misc/rbednark/docs/*diar*"

#function trapit.supervisorctl.status.all() {
#    (
#    setopt shwordsplit
#    servers="nb-1 zb-1 zb-2 zb-3"
#    for server in $servers; do 
#        ssh $server supervisorctl status
#    done
#    )
#}
#function trapit.get.all.logs() {
#    (
#    ssh nb-1 '(cd /tmp; mkdir tmp.rbednark.logs; )'
#    )
#}
#function trapit.show.all.logs() {
#    (
#    ssh nb-1 cat '/trapit/*/v?/*log'
#    )
#}

################################################################################
# Tixie:
################################################################################
PemRobKey=$DirDropbox/Rob/aws/RobKey.pem
MachineRobAWS='ec2-23-20-227-24.compute-1.amazonaws.com'
DirTixieGit=~/git/tixie-web
DirTixieSrc=$DirTixieGit/src
DirTixieApps=$DirTixieSrc/apps
DirTixieRob=$DirDropbox/Rob/tixie
DirTixieTest=$DirTixieSrc/tixie_public
FileNotesTixie="$DirQuiz/tixie.notes"
FileQuizTixie="$DirQuiz/db_tixie"
MachineDevRobAdminClone20120723='ec2-72-44-37-175.compute-1.amazonaws.com'
MachineDevRobRestClone20120723='ec2-50-17-30-53.compute-1.amazonaws.com'
MachineDevRobDbClone20120720='ec2-23-20-15-37.compute-1.amazonaws.com' 
MachineDevRobDbClone20120727='ec2-23-22-116-221.compute-1.amazonaws.com' 
MachineDevRobDbClone20120720Clone20120724='ec2-50-17-157-250.compute-1.amazonaws.com'
MachineDevRobDbPg9_20120712='ec2-23-22-205-63.compute-1.amazonaws.com'
MachineDevRobPg9_12_04_20120717='ec2-107-21-163-193.compute-1.amazonaws.com'
MachineDevRobPg9_12_04_20120727='ec2-107-21-71-108.compute-1.amazonaws.com'
MachineDevRobWebClone20120626='ec2-107-20-36-130.compute-1.amazonaws.com'
MachineDevRobWebClone20120719='ec2-23-22-137-206.compute-1.amazonaws.com'
MachineCorpTixie='corp.tixie.com'
MachineProdAdmin='ec2-50-17-242-66.compute-1.amazonaws.com'
MachineProdCron='production-cron-01.in.tixie.org'
MachineProdDb84='ec2-107-20-219-93.compute-1.amazonaws.com'
MachineProdDb='ec2-23-22-135-206.compute-1.amazonaws.com'
MachineProdDb01='ec2-184-73-115-109.compute-1.amazonaws.com'
MachineProdWeb='ec2-75-101-151-220.compute-1.amazonaws.com'
MachineQAiPhoneAPI='ec2-50-17-70-177.compute-1.amazonaws.com'
MachineQADb='qa-db.in.tixie.org'
MachineQATixie='qa-web-develop.in.tixie.org'
MachineQA_DB_Tixie='qa-db.in.tixie.org'
PemTixie515=$DirDropbox/Rob/tixie/tixie20120515.pem
PemTixieKey=$DirDropbox/Rob/tixie/tixiekey.pem
alias   cdapps="cd $DirTixieApps"
alias   cdcommands="cd /Users/rob/git/tixie-web/src/apps/tixie/management/commands/"
alias   cdsrc="cd $DirTixieSrc"
alias   cddropbox.tixie="cd $DirDropbox/Rob/tixie; ls"
alias   cdtixie="cd $DirDropbox/git/tixie-web"
alias   cdtixierob="cd $DirTixieRob; ls"
alias   cdwebapp="cd /var/webapp/tixie_public"
#alias   subl.django="subl ~/.virtualenvs/tixie-web/lib/python2.7/site-packages/django/"
alias   subl.tixie="subl /Users/rob/git/tixie-web/src"
################################################################################

################################################################################
# Postgres
################################################################################
alias   postgres.grep.ignore="egrep -v 'lock of type ShareLock|Connection reset by peer|GMT LOG:  duration:'"

alias	ci="ci -zLT"
# I think "cmd" works for the default cygwin window, but not for rxvt
#alias	cls="cmd /c cls"
# The following echo sequence works for rxvt.
alias cls="echo -ne '\033c'" 
alias	co="co -zLT"
alias	cp="cp -ip "

alias   datestamp='date +%Y.%m.%d.%a.%H.%M.%S'
alias   dc='docker-compose'
alias   dclogs='docker-compose logs --timestamps --follow'
alias	diffbednarkcom="diff -r $DirBednarkCom /tmp/bednark.com"
alias	dotrc="source $FileRc"

alias   finddropboxconflicted='find $DirDropbox | grep conflicted'
alias	findex="ls -l | grep '^...x'"
if uname | grep -i linux > /dev/null; then
	true
elif $MacOSX; then
    alias chrome="open -a Google\ Chrome"
    alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
	#alias	firefox="open /Applications/"
    :
else
	alias	firefox="/cygdrive/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe"
fi

# git aliases
# alias   gb="echo git branch; git branch"
# alias   gc="echo git checkout $*; git checkout"
# alias   gf="echo git fetch; git fetch"
alias   grep="grep --color"
alias   git.log="(set -x; git log --all --graph --oneline --abbrev-commit  --decorate; set +x)"
alias   git.log.branches='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"'
alias   git.log.branches.color='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias   git.show.toplevel="git rev-parse --show-toplevel"
alias   git.vimdiff="git difftool --no-prompt --tool=vimdiff"
alias   git.vim.cached='vim $(git diff --name-only --cached)'
alias   git.vim.conflicts='vim $(git diff --name-only --diff-filter=U)'
alias   git.vim.modified='vim $(git diff --name-only --diff-filter=M)'
#alias   git.diff.old="(git difftool  --ignore-submodules=dirty --extcmd=diff --no-prompt $*)"

alias   help.find.delete='echo find . -name "*.pyc" -delete'

if $MacOSX; then
	alias	ls="ls -G"
    # Commented-out Wed 3/5/14 4:20pm after upgrade to Mavericks.
    # I cannot get mvim working with command-t on Mavericks.
    #alias   vim='mvim -v'
    alias   iphone.simulator="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app/Contents/MacOS/iPhone\ Simulator"
else
	alias	ls="ls -CF --color"
    alias 	gvim="  /cygdrive/c/Program\ Files\ \(x86\)/Vim/vim72/gvim.exe"
    alias 	gvimdiff="c:/WINDOWS/gvimdiff.bat"
fi

alias   idle='env python3 /usr/lib/python3.2/idlelib/idle.py &'

alias   lsless="ls -lt|less"
alias	lsx="ls -l | grep '^-..x'"
alias	lib="title library; telnet multnomah.lib.or.us"

alias	manoj="telnet $MachineManoj"
alias	mv="mv -i"
alias   mycmd_old_pre_v1.7_django_versions='(set -x; rm -f mydb.db db.sqlite3;./manage.py syncdb --noinput; ./manage.py mycmd)'
alias   mycmd='(set -x; rm -rf mydb.db db.sqlite3 myapp/migrations;./manage.py makemigrations; ./manage.py migrate; ./manage.py mycmd)'
alias   mycmd.nosync='(set -x; ./manage.py mycmd)'

alias 	mounttestadm="sudo mkdir -p /testadm; sudo mount $MachineCurtis:/testadm /testadm"

alias   open.postgresql.manual="open $DirDropbox/Rob/postgresql-9.4-US-entire-manual-dated-Feb-20-2015.pdf"
alias   open.resume="open $DirResume/*pdf"
alias   open.solr.manual="open $DirDropbox/Rob/apache-solr-ref-guide-4.10-downloaded-Feb-20-2015.pdf"
alias   open.sqlalchemy.manual="open $DirDropbox/Rob/sqlalchemy-0.9.8-downloaded-Feb-20-2015.pdf"
alias   open.sqlalchemy.manual.adobe.reader="open.adobe.reader $DirDropbox/Rob/sqlalchemy-0.9.8-downloaded-Feb-20-2015.pdf"
alias   open.the.effective.engineer="open $DirDropbox/Rob/the-effective-engineer-sample.pdf"

if $MacOSX; then
alias   osx.wifi.reboot="networksetup -setairportpower en1 off; networksetup -setairportpower en1 on"
fi

alias	pgoog="ping google.com"
alias 	pok="title poughkeepsie sanfs00; telnet 9.12.20.42; ssh rbednark@9.12.20.42"
alias	pw3="ping w3.ibm.com"
DirPyWin2="c:/Python27"
DirPyWin3="c:/Python32"
DirPy2="c:/Python27"
DirPy3="c:/Python32"
alias	pydocwin2="$DirPyWin2/python.exe $DirPyWin2/Lib/pydoc.py"
alias	pydocwin3="$DirPyWin3/python.exe $DirPyWin3/Lib/pydoc.py"
alias	pythonwin="$DirPyWin2/python.exe"
alias   py2="$DirPy2/python.exe"
alias   py2w="$DirPy2/pythonw.exe"
alias   py=py2
alias   py3="$DirPy3/python.exe"
alias   py3w="$DirPy3/pythonw.exe"
alias	pywin=pythonwin
alias   pipwin="$DirPyWin2/Scripts/pip.exe"

alias	quote="echo '================================================================================'; $BinQuote --cfg $DirSync/quote.cfg --linelength 160 $FileQuotes; echo '================================================================================'"
alias	quoteOld="echo '================================================================================'; $BinQuote --old --cfg $DirSync/quote.cfg --linelength 160 $FileQuotes; echo '================================================================================'"

alias	rm="rm -i"
alias   rm.pyc.files="(set -x; find . -name '*.pyc' -delete; set +x)"

alias   scp.nginx.logs="scp -Cpr -i $PemTixie515 ubuntu@$MachineProdWeb:/var/log/nginx ."
alias   screensaver="gnome-screensaver-command --activate"
alias	script_date="script ~rbednark/logs/typescript.`date +%Y.%m.%d.%H.%M.%S.%a`"
alias	script_date2='script ~rbednark/logs/typescript.`date +%Y.%m.%d.%H.%M.%S.%a`'
#alias   seleniumServerRun="java -jar C:/cygwin/home/sara/selenium/selenium-server-1.0.3/selenium-server.jar"
alias   seleniumServerRun="title Selenium Server; java -jar C:/cygwin/home/sara/selenium-2.0b1/selenium-server-standalone-2.0b1.jar"
#alias	sshmtproxy="echo mtd@t@2011; ssh root@mtproxy.futurewei.ebento.net"
#alias	sshmtproxy8="echo wloe...; ssh rbednark@mtproxy8.ebento.net"
#alias	sshtest="title douglas; ssh rbednark@$hostDouglas"
alias   ssh="ssh -A"
alias   ssh.rob-aws="ssh -i $PemRobKey ubuntu@$MachineRobAWS"

# Tixie machines
alias   ssh.weechat=ssh.rob-aws
# alias   ssh.dev-rob-admin-clone-20120723="ssh -i $PemTixie515 ubuntu@$MachineDevRobAdminClone20120723"
# alias   ssh.dev-rob-db-pg9-12.04-20120717="ssh -i $PemTixie515 ubuntu@$MachineDevRobPg9_12_04_20120717"
# alias   ssh.dev-rob-db-pg9-12.04-20120727="ssh -i $PemTixie515 ubuntu@$MachineDevRobPg9_12_04_20120727"
# alias   ssh.dev-rob-db-pg9-20120712="ssh -i $PemTixie515 ubuntu@$MachineDevRobDbPg9_20120712"
# alias   ssh.dev-rob-db-pg9-20120727="ssh -i $PemTixie515 ubuntu@$MachineDevRobDbPg9_20120727"
# alias   ssh.dev-rob-db-clone-20120720="ssh -i $PemTixieKey ubuntu@$MachineDevRobDbClone20120720"
# alias   ssh.dev-rob-db-clone-20120720-clone2-20120724="ssh -i $PemTixieKey ubuntu@$MachineDevRobDbClone20120720Clone20120724"
# alias   ssh.dev-rob-db-clone-20120727="ssh -i $PemTixie515 ubuntu@$MachineDevRobDbClone20120727"
# alias   ssh.dev-rob-rest-clone-20120723="ssh -i $PemTixie515 ec2-user@$MachineDevRobRestClone20120723; set +x"
# alias   ssh.dev-rob-web-clone-20120626="ssh -i $PemTixie515 ubuntu@$MachineDevRobWebClone20120626"
# alias   ssh.dev-rob-web-clone-20120719="ssh -i $PemTixie515 ubuntu@$MachineDevRobWebClone20120719"

# alias   ssh.corp.tixie="ssh -i $PemTixie515 ubuntu@$MachineCorpTixie"
# alias   ssh.prod-admin="ssh -i $PemTixieKey ubuntu@$MachineProdAdmin"
# alias   ssh.prod-cron="ssh -i $PemTixieKey ubuntu@$MachineProdCron"
# alias   ssh.prod-db="ssh -i $PemTixie515 ubuntu@$MachineProdDb"
# alias   ssh.prod-db-01="ssh -i $PemTixieKey ubuntu@$MachineProdDb01"
# alias   ssh.prod-db-8.4="ssh -i $PemTixieKey ubuntu@$MachineProdDb84"
# alias   ssh.prod-web="ssh -i $PemTixie515 ubuntu@$MachineProdWeb"
# alias   ssh.qa-iphone-api="ssh -i $PemTixie515 ubuntu@$MachineQAiPhoneAPI"
# alias   ssh.qa-web.tixie="ssh -i $PemTixieKey ubuntu@$MachineQATixie"
# alias   ssh.qa-db.tixie="ssh -i $PemTixieKey ubuntu@$MachineQA_DB_Tixie"

alias   source.django="source $DirDropbox/bin/learn/dir.learn.django.projects/source.venv"
alias   sourcetree="open -a SourceTree"
alias   sourcetree.this.repo='sourcetree "$(git rev-parse --show-toplevel)"'
alias   subl2="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias   subl3="/Applications/Sublime\ Text\ 3.app/Contents/SharedSupport/bin/subl"
alias   subln="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias   subl=subln

alias   tail.downtime="tail -999f $FilePingSymlinkActive | grep time.DOWN"
alias   tail.summary="tail -99f $FilePingSymlinkActive | grep SUMMARY"
alias   ping.tail.time="tail -5 $FilePingSymlinkActive; tail -99f $FilePingSymlinkActive | grep SUMMARY:.time"
alias   ping.tail.down="tail -5 $FilePingSymlinkActive; tail -9999f $FilePingSymlinkActive | grep 'SUMMARY: time DOWN:'"
alias   ping.tail="tail -20f $FilePingSymlinkActive"
alias   ti=title
alias	tlab="title svc driver; telnet $MachineSvcDriver"
alias 	tbvt3="telnet $MachineBvt3Driver9"
alias	tcurtis="telnet $MachineCurtis"
alias	telm35="telnet $elm35"
alias	telm36="telnet $elm36"
alias	telm37="telnet $elm37"
alias	telm50="telnet $elm50"
alias	tritu="telnet $MachineRitu"
alias	trob="ssh -l root $MachineRob"
alias	ssvcdriver="title SVC Driver; ssh root@$MachineSvcDriver"
alias	tsvcdriver="title SVC Driver; telnet $MachineSvcDriver"
alias	taix="telnet 192.168.40.25"

if $MacOSX; then
    alias top="top -c d -o cpu -s 2"
fi

alias	vaddrs="title vi email addresses; vici $FileEmailAddrs"
alias   vagrant.halt='cdvagrant; vagrant status; time vagrant halt; vagrant status'
alias   vagrant.ssh='cdvagrant; vagrant status; date; time vagrant up; date; vagrant ssh'
alias   vagrant.status='cdvagrant; vagrant status'
alias   vask="cd $DirQuiz; vici db_*ask*stackoverflow"
alias	vconvert="title teamroom.how.to.convert.to.flexsan.html; cd $DirDoc; explorer.exe teamroom.how.to.convert.to.flexsan.html; vici teamroom.how.to.convert.to.flexsan.html"
alias	vebento="cdsel; vici ebento.py"
alias 	vhw="title Huawei; vici $FileToDo $FileHuawei $FileJ $FileDoc"
alias	vgoserver="title teamroom.design.proposal.eliminating.GoServer.html; cd $DirDoc; explorer.exe teamroom.design.proposal.eliminating.GoServer.html; vici teamroom.design.proposal.eliminating.GoServer.html"
alias	vgtest="title gtest.html; cd $DirDoc; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/teamroom.brownbag.gtest.html` &); vici teamroom.brownbag.gtest.html"

alias	vhowtorun="vici $DirDoc/teamroom.how.to.run.html"
alias	vninja="title ninja.html; cd $DirDoc; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/ninja.html` &); vici ninja.html"
alias	vobs="title readme.obs.html; cd $DirDoc; explorer.exe readme.obs.html; vici readme.obs.html"
alias	vi=vim

alias   vdone="vici $FileAccomplishments"
alias 	vj.other="vici $FileJTmp $FileToDo $FileDiary $FileHuawei"
alias 	vj="title j; vici $FileJ ; echo vici $FileJTmp $FileToDo $FileDiary $FileHuawei"
alias   vjtmp="title interim j; vici $FileJTmp"
alias 	vjtmp.read.only="title j; vim -R $FileJ $FileJTmp $FileToDo $FileDiary $FileHuawei"
alias   vl='vim -c "normal '\''0"'  # vim the last file that was edited in vim; '0 means the most recent file; "-c" means execute this command; I think "normal" means start in normal mode, but I'm not sure
alias	vlyrics="title lyrics; vici $DirDoc/lyrics.txt"
alias   vmeetups="cd $DirQuiz; vici *meetups"
alias 	vone="vici $DirDoc/teamroom.one.button.html"
alias	vphone="title vphone; vici $FilePhone"
alias 	vpicts="vici $FilePicts"

# files very active with for a limited duration
alias   vatd="cd $DirLearn; vici atd_survey_filter.py"

# Quiz files
alias   vabraham.hicks.quotes="vici $DirQuiz/abraham-hicks.quotes"
#alias   vachievements.atlatl="title vachievements.atlatl; vici $DirQuiz/achievements.atlatl"
alias   vapps="title vapps; cd $DirQuiz; vici db_apps"
alias   varchitecture="vici $DirQuiz/db_software_design_architecture"
alias   vatlatl="title vatlatl; vici $DirQuiz/db_atlatl"
alias   vcoverletters="title cover.letters; vici $DirQuiz/job_cover_letters_applications.txt"
alias   vdaily="title vdaily; cd $DirQuiz; vici db_daily_review"
alias   vdiary="title vdiary; cd $DirQuiz; vici db_diary"
alias   vdjango="title vdjango; cd $DirQuiz; vici db_django"
alias   vfamily="cdfam; vim -R *txt"
alias   vfun="cd $DirQuiz; vici db_fun"
alias   vgit="title vgit; cd $DirQuiz; vici db_git"
alias   vgratitude="cd $DirQuiz; vici gratitude"
alias   videalist="cd $DirQuiz; vici idealist"
alias   vinterview="cd $DirQuiz; vici db_interview_questions_master_template"
alias   viphone="title viphone; cd $DirQuiz; vici *iphone*"
alias   vjavascript="cd $DirQuiz; title db_javascript; vici db_javascript"
alias   vjobsearch2016="vici $DirQuiz/job_search_Sep_2016"
alias   vjobsearch="vici $DirQuiz/cover_letters* $DirQuiz/job_search_Sep_2016 $DirQuiz/portland.job.scene $DirQuiz/job.search.Aug.2015 $DirQuiz/db_resume $DirDoc/cover.letters.txt $DirDoc/job.openings.descriptions.txt $DirQuiz/job.descriptions $DirQuiz/job.references"
alias   vjournaling="cd $DirQuiz; vici db_journaling"
alias   vlearn="cd $DirQuiz; vici db_learn"
alias   vlos_angeles="vici $DirQuiz/db_los_angeles"
alias   vmac="title vmac; cd $DirQuiz; vici db_mac"
alias   vmaster.manifest="title vmaster.manifest; cd $DirQuiz; vici master.manifest.txt"
alias   vmisc="cd $DirQuiz; vici db_misc"
alias   vmoovel="vici $DirMoovel/moovel.txt"
alias   vpaste="vici ~/tmp/paste"
alias   vpeople.quiz="vici $DirQuiz/db_quiz_people"
alias   vprogramming="cd $DirQuiz; vici db_programming"
alias   vpython="title vpython; cd $DirQuiz; vici db_python"
alias   vquiz="cd $DirQuiz; vici *xie *nix *apps *thon *ogy"
alias   vquizme="cd $DirQuizMe; vici README"
alias   vquizmedb="vici.onefile $DirAddToQuizme/learn_add_to_quizme; vim $DirAddToQuizme/learn_add_to_quizme  $DirQuizMe/db_dumps/latest.dump.txt; vici.onefile $DirAddToQuizme/learn_add_to_quizme"
alias   vresume=vjobsearch
alias   vresume.word="open -a 'Microsoft Word' $DirDropbox/Documents/Rob.Bednark.resume.docx"
#alias   vresume.pdf="open -a "Microsoft Word"'
alias   vselenium="vici $DirQuiz/db_selenium"
alias   vtalks="vici $DirQuiz/db_talks"
alias   vsql="title vsql; cd $DirQuiz; vici db_sql"
alias   vstudy="title vstudy; cd $DirQuiz; vici db_study_notes_journal_diary"
alias   vsurvey="title vsurvey; cd $DirQuiz; vici db_mike_ames_surveygizmo"
alias   vtrapit="title vtrapit; cd $DirQuiz; vici db_trapit"
alias   vunix="title vunix; cd $DirQuiz; vici db_unix"
alias   vvim="title vvim; cd $DirQuiz; vici db_vim"
alias   vtixie="title vtixie; cd $DirQuiz; vici $FileQuizTixie $FileNotesTixie"
alias   vtixieconfidential="title vtixie; vici $DirQuiz/db_tixie_confidential"
alias   vweb="title vweb; cd $DirQuiz; vici *web*"
alias	vrc="title vrc; (cd `dirname $FileRc`; vici `basename $FileRc`); dotrc"
alias	vrecipes="vici $DirDoc/fvt.team.recipes.txt"
alias	vrequirements="vici $DirDoc/teamroom.fvt.requirements.html"
alias   v.six.degrees="vici $DirQuiz/db_six_degrees_of_connection"
alias   vspinosa="vici $DirDoc/spinosa.property.values.txt"
alias vstocks="vici  $DirQuiz/db_stocks_options $FileStocks $FileStockNotes"
alias	vpsych="vici $FileMyPsychology"
alias vtoday="title vtoday; vici  $FileAccomplishments $FileDoc"
alias vtower="title vtower; vici $DirDoc/tower.hill.property.values.txt"
alias vtodo="title ToDo; vici  $FileLearnTodo $FileTodayNew $FileToday"
alias vlists="title vlists; rm -f /tmp/tmp.todo*; /home/rbednark/bin/todo.py --makeLists; vim  /tmp/tmp.todo*"
alias	vtips="title tips.html; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/tips.html` &); vici $DirDoc/tips.html"
alias vvimrc="cd `dirname $FileVimrc`; vici `basename $FileVimrc`"
alias vxd="cd $DirUnixConfigFiles; vici .Xdefaults"
alias	winmerge="'/cygdrive/c/Program Files/WinMerge/WinMerge.exe'"

################################################################################
# Tixie functions:
################################################################################
function psql.dev-rob-pg9-12.04-grep-all-data() {
    regex="$1"
    (python -u $DirDropbox/bin/learn/pg.show.all.data.all.tables.py | egrep -i --context=6 "^\+|$regex" )
}
function psql.dev-rob-pg9-12.04-show-all-data() {
    (python -u $DirDropbox/bin/learn/pg.show.all.data.all.tables.py)
}
function psql.dev-rob-pg9-12.04-select-events() {
    (psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM v_allevents_and_draws ORDER BY event_date' )
}
function psql.dev-rob-pg9-12.04-20120727() {
    (psql --host $MachineDevRobPg9_12_04_20120727 --port 5432 --user tixie_admin --dbname tixie_main )
}
function psql.dev-rob-pg9-12.04() {
    (psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main )
}
function psql.PROD-DB() {
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main $* )
}
function psql.vagrant() {
    (psql --host localhost --port 5433 --user tixie_admin --dbname tixie_main )
}
function psql.qa-db() {
    (date; psql --host $MachineQADb --port 5432 --user tixie_admin --dbname tixie_main )
}
function psql.list-tables.rob-dev-pg9() {
    (date; psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main --command '\d')
}
function psql.list-users.rob-dev-pg9() {
    (date; psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY username;')
}
function psql.list-users.PROD-DB() {
(date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT au.join_date, au.username, au.first_name, au.last_name, au.email, aa.dob, aa.tokens, aa.win_eligible, au.is_staff, au.is_superuser FROM accounts_account aa, auth_user au WHERE au.id = aa.user_id ORDER BY au.join_date;')
    #(date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY username;')
    #(date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT id,guid,user_id,facebook_id,access_token,avatar,site_password_set,email_notifications,facebook_wall_notifications FROM accounts_account ORDER BY id;')
}
function psql.list-users.date_joined.PROD-DB() {
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY date_joined;')
}
function psql.list-users.last_login.PROD-DB() {
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY last_login;')
}
function psql.list-hot-events.PROD-DB() {
    date
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM v_hot_analysis ORDER BY hotscore;')
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM vw_hot_events  ORDER BY uk_bid_cnt_by_event;')
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM vw_hot_events2 ORDER BY uk_bid_cnt_by_event;')
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command '\d+ v_hot_analysis')
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command '\d+ vw_hot_events')
    (date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command '\d+ vw_hot_events2')
    date
}
function psql.get-bid-log.PROD-DB() {
    #( # Put in parens so that "set -x" goes away after the subshell;
    #set -x;
    #date;
    set -x
    psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM sweeps_bid_log ORDER BY bid_date;'
    #)
}
function scp.from.prod-db() {
    scp -i $PemTixie515 ubuntu@$MachineProdDb:$1 .
}
function scp.to.aws() {
    file=$1
    server=$2
    scp -i $PemTixie515 $file $server:/tmp
    set +x
}
function scp.latest.dump() {
    scp -i $PemTixie515 ubuntu@$MachineProdDb:/var/lib/postgresql/backups/hourly/tixie_main.dump.1 ~/Desktop/vagranttest
    set +x
}
function scp.get.tixie.reports() {
    scp -C -i $PemTixie515 ubuntu@$MachineProdDb:/var/lib/postgresql/'*.csv' $DirTixieRob/reports
    set +x
}
function scp.to.rob-dev() {
    scp -i $PemTixie515 $@ ubuntu@$MachineDevRobWebClone20120626:/tmp
    set +x
}
function scp.from.rob-dev() {
    scp -i $PemTixie515 ubuntu@$MachineDevRobWebClone20120626:$@
    set +x
}
function tixiefind() {
    findRegex="$*"
    cd $DirTixieSrc
    find . -name "$findRegex" 
}
function tixiefindvi() {
    findRegex="$*"
    cd $DirTixieSrc
    find . -name "$findRegex" | xargs --no-run-if-empty vim
}
function tixiegrepvi() {
    grepArgs="$*"
    echo "grep args=[$grepArgs]"
    cd $DirTixieSrc
    if grep -lr $grepArgs . > /dev/null 2>&1; then
        grep -lr $grepArgs . | xargs --no-run-if-empty vim
    else
        echo "grep found nothing"
    fi
    set +xv
}



################################################################################
### Functions
################################################################################

function aws.instance.info() {
    # Show the instance info for the AWS you are logged-in to.
    AWS_PUBLIC_HOSTNAME=$(curl --silent http://169.254.169.254/latest/meta-data/public-hostname)
    AWS_LOCAL_HOSTNAME=$(curl --silent http://169.254.169.254/latest/meta-data/local-hostname)
    AWS_HOSTNAME=$(curl --silent http://169.254.169.254/latest/meta-data/hostname)
    AWS_AMI_ID=$(curl --silent http://169.254.169.254/latest/meta-data/ami-id)
    AWS_INSTANCE_TYPE=$(curl --silent http://169.254.169.254/latest/meta-data/instance-type/)
    AWS_PUBLIC_KEYS=$(curl --silent http://169.254.169.254/latest/meta-data/public-keys/)
    set | grep '^AWS_' | sort
}

function check.cmd.before.tests() {
	for oneFile in `\ls -1`; do
		echo "+ grep $oneFile cmd.before.tests"
		grep $oneFile cmd.before.tests
		rc="$?"
		if [ $rc -eq 0 ]; then
			echo "YES: $oneFile"
		else
			echo "NO : $oneFile"
		fi
	done
}

function cilm () {
	DirBase=`dirname $1`
	mkdir -p $DirBase/RCS
	ci -zLT -t-. -l -m. $*
}
function cd.package.dir() {
    # cd to the directory that contains the specified python package
    _py_package=$1
    _py_file=$(python -c "import ${_py_package}; print(${_py_package}.__file__)")
    cd $(dirname ${_py_file})
}
function dc-rebuild-container() {
    container=$1
    (set -x;
     docker-compose stop $container;
     docker-compose rm --force $container;
     docker-compose build $container;
     docker-compose create $container;
     docker-compose start $container;
    )
}
function emailaddr () {
  grep -i $@ $FileEmailAddrs
}
function find.portal () {
	 find .|xargs grep $@ /dev/null
}
function vifind.portal() {
	 files=`find .|xargs grep -l $@ /dev/null`
	 vim -R $files
}

function gitall() { 
    # run the specified git command on all subdirectories
    for dir in *; do 
        echo "================================================================================"
        echo $dir
        echo "================================================================================"
        cd $dir
        git $*
        cd ..
    done
}
function git.files.changed.in.commit () {
  # --no-commit-id => don't show the commit ID
  # --name-only    => show only file names, not owner, group, perms
  # -r             => recurse into sub-trees
  (set -x; git diff-tree --no-commit-id --name-only -r $*)
}

function git.files.added.and.changed.in.commit () {
  # --no-commit-id => don't show the commit ID
  # --name-only    => show only file names, not owner, group, perms
  # -r             => recurse into sub-trees
  (set -x; git ls-tree --name-only -r $*)
}

function git.diff.old () {
  (set -x; git difftool  --ignore-submodules=dirty --extcmd=diff --no-prompt $*)
}

function grepaliases () {
	grep -i $@ $FileEmailAddrs
}
function pless() {
    # pipe stdout/stderr to less
    $@ 2>&1 | less
}
function latest() {
    _file=$(ls -1t $@ | head -1)
    if [ "$@" != "" ]; then
        _dir="$@" 
        echo "$_dir/$_file"
    else
        echo $_file
    fi
}
function ninja.grep.tests () {
	egrep -v 'CleanupClient|GoServer|GoMake|InstallMDS|win_cleanup|^\+----------' $@ 
}
function phone () {
  grep -i $@ $FilePhone
}
function ping.monitor() {
    title ping.monitor
    python -u $DirDropbox/bin/learn/log_track_monitor_online_wifi_status_with_ping.py >> $FilePingOutput 2>&1 &
    rm -f $FilePingSymlinkActive
    ln -s $FilePingOutput $FilePingSymlinkActive
    sleep 3;
    ping.tail.time
}
function rcs.show.lock() {
    for oneFile in $@; do
        #echo "File: $oneFile"
        echo -n "locks:  (your userid = [$(whoami)])"
        rlog $oneFile | grep --after-context=1 'locks:' | grep -v locks:
    done
}
function rcs.unlock.lock() {
    for oneFile in $@; do
        echo "File: $oneFile"
        rcs.show.lock $oneFile
        rcs -u -M $oneFile
        rcs -l -q $oneFile
        rcs.show.lock $oneFile
    done
}

function scp.sync() {
	allFiles=""
	for oneFile in $@
	do
		allFiles="$allFiles $DirDriverSync/$oneFile"
	done
	set -x
	scp -p $allFiles .
	set +x
}

function subl.django() {
    dir_django=$(python -c "import django,os; print os.path.dirname(django.__file__)")
    subl $dir_django
}

function title_linux {
    echo -ne "\e]2;$*\a"
}

function title_set {
    # iTerm2  - set the name of the tab, the window, or both
    # https://hacksformacs.wordpress.com/2015/08/20/setting-iterm2-tab-and-window-titles/
    _mode=$1; shift  # 0=both  1=tab  2=window
    _title="$@"
    echo -ne "\033]${_mode};"${_title}"\007"
}

title.both()   { title_set 0 $@; }
title()        { title_set 1 $@; }
title.tab()    { title_set 1 $@; }  # Note that title.tab set just the tab only if you've already set just the window
title.window() { title_set 2 $@; }


function titlessh {
	ssh $Rob ~/bin/title $@
}
### Note: this function must be defined after the "alias cilm", otherwise cilm is not resolved in this function.
function rcsdiff_files_differ {
    rcsdiff $@ > /dev/null 2>&1
    return $?
}
function rcsdiff_show_files_that_diff {
    for one_file in $@; do
        if [ ! -d $one_file ] && ! rcsdiff_files_differ $one_file; then
            echo $one_file
            #rcs.show.lock $one_file
        fi
    done
}
function vici.onefile() {
    onefile=$1
    title $(basename $onefile)
    DirCurDir=$(pwd)
    DirBase=`dirname $onefile`

    # Go to the top level of the repo to add all files that haven't been added
    cd $DirBase
    pwd
    DirGit=$(git rev-parse --show-toplevel)
    cd "$DirGit"
    pwd

    # Show status
    echo "================================================================================"
    git.diff.old
    echo "================================================================================"
    # git --no-pager status --ignore-submodules=dirty

    # Add all files that aren't already in the repo
    # echo "+ git add -A"
    git add -A

    # Commit
    # echo "git commit -a -m 'Auto commit from vici'"
    git commit -a -m 'Auto commit from vici'

    echo "================================================================================"
    git.diff.old
    echo "================================================================================"
    # git --no-pager status --ignore-submodules=dirty
    # Now cd back to the directory where the user was to begin with.
    cd $DirCurDir
    # echo "Hit return to continue (after commit, before vim; onefile=$onefile)..."; read x
}
function vici () { 
    # Use git instead of rcs
    # capture the current dir and return to it after we are done

    if echo $SHELL | grep zsh > /dev/null; then
        # setopt shwordsplit causes zsh to behave like bash for splitting a string (e.g., $files)
        setopt shwordsplit
    fi

    # ISSUE: 4/18/14: vici does not work for multiple files; why not?
    #   o 4/18 7:42am I removed the quotes from files=$@ -- result: no difference; still has space in filename
    cur_dir=$(pwd)
    files=$@
    # Would be best to get a list of the repositories for all the files, and only do one commit
    # for each repository.  For now, just do it for each.
    # echo "DEBUG: files=[$files]"
    # echo "DEBUG: \$#=[$#]"
    for onefile in $files; do
        # echo "DEBUG: onefile=[$onefile]"
        vici.onefile $onefile
    done
    # echo "Hit return to [vim $files]..."; read FOO
    vim $files
    for onefile in $files; do
        # echo "Hit return to [vici.onefile $onefile]..."; read FOO
        vici.onefile $onefile
    done

    # cd back to the directory we were in before we started
    cd $cur_dir
}
function vici.old () {
	DirBase=`dirname $1`
    # Create the RCS dir if it doesn't exist
	mkdir -p $DirBase/RCS
    files="$@"

	rcsdiff $files
	echo "==================================================================="
    # checkin all the files before editing them
	cilm $files
    if ! rcsdiff_files_differ $files; then
            # Assert: the files are different, even after attempting to check them all in
            for oneFile in $files; do
                if [ -e $oneFile ] && rcsdiff_files_differ $oneFile; then 
                    # ASSERT: the file exists, and it differs from the RCS version
                    rcs.show.lock $oneFile
                    echo "ERROR: file [$oneFile] cannot be checked-in.  Want to rcs.unlock.lock? [y/N]"
                    read resp
                    if [ "$resp" = "y" ]; then
                        echo "You said yes [$resp].  Unlocking and cilm"
                        rcs.unlock.lock $oneFile
                        rcsdiff $oneFile
                        cilm $oneFile
                        rcs.show.lock $oneFile
                        echo "Hit return to continue..."; read foo
                    else
                        echo "you said NO [$resp]"
                    fi
                elif [ ! -e $oneFile ] && [ -e RCS/$oneFile,v ]; then
                    echo "WARNING: [$oneFile] does not exist but [RCS/$oneFile,v] does exist."
                    echo "Hit return to continue..."; read foo
                else
                    # either the file is not different from the RCS version,
                    # or else this is a new file that has not yet been created and saved.
                    :
                fi
                set +xv
            done
    fi
    echo "Hit return to continue..."; read x
    # Edit the files
	vim $files
    # Show the diffs
	rcsdiff $files
	echo "==================================================================="
    # Checkin the files again
	cilm $files
}
function	vabout() { 
	title aboutMe
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileAbout` &)
	vici $FileAbout $FileIndex
}

function	vblog() { 
	title blog
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileBlogHtml` &)
	vici $FileBlogHtml $FileIndex $FileBlog $FileSiteMapXml
	upload.to.bednark.com $FileBlogHtml $FileIndex
}

function vbooknotes() { 
	title bookNotes
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileBooknotes` &)
	vici $FileBooknotes $FileIndex
	upload.to.bednark.com $FileBooknotes $FileIndex
}

function	vemailgroups() { 
	title email.groups.html
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileEmailGroups` &)
	vici $FileEmailGroups $FileIndex
	upload.to.bednark.com $FileEmailGroups $FileIndex
}

function	vcontact() { 
	title bednark.com contact.info.cpp
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileContactInfo` &)
	vici $FileContactInfo
	upload.to.bednark.com $FileContactInfo
}
function	vindex() { 
	title bednark.com index.cpp
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileIndex` &)
	vici $FileIndex
	upload.to.bednark.com $FileIndex
}

function	vpeople() { 
	title people.I.know
	cd $DirBednarkCom
    if $MacOSX; then
        # open $FilePeopleHtml http://bednark.com/people.I.know.html
        :
    else
        (firefox file:///`cygpath -m $FilePeopleHtml` &)
    fi
	vici $DirQuiz/*people $FilePeopleHtml $FileInformixEmployees $FilePeopleTxt $FileIndex $DirFamilyTree/*txt
	# upload.to.bednark.com $FilePeopleHtml $FileBlogHtml $FileIndex
}

function	vhumor() { 
	title humor
	cd $DirBednarkCom
    if $MacOSX; then
        open -a Google\ Chrome $FileHumor
    else
        (firefox file:///`cygpath -m $FileHumor` &)
    fi
	vici $FileHumor $FileIndex
	upload.to.bednark.com $FileHumor $FileIndex
}
function	vquotes() { 
	title quotes
	cd $DirBednarkCom
    if $MacOSX; then
        #(firefox file:///$FileQuotes http://bednark.com/quotes.html &)
        open file:///$FileQuotes http://bednark.com/quotes.html
    else
        (firefox file:///`cygpath -m $FileQuotes` http://bednark.com/quotes.html &)
    fi
	vici $FileQuotes $FileIndex $FileSitemap
	upload.to.bednark.com $FileQuotes $FileIndex $FileSitemap
}
function	vrecommendations() { 
	title recommendations
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileRecommendations` &)
	vici $FileRecommendations $FileIndex
	upload.to.bednark.com $FileRecommendations $FileIndex
}

function	vsitemap() { 
	title site.map.cpp
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileSiteMapHtml` &)
	vici $FileSiteMapHtml 
	upload.to.bednark.com $FileSiteMapHtml
}
function	vsoftwarequotes() { 
	title software.quotes
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileSoftwareQuotes` &)
	vici $FileSoftwareQuotes $FileIndex
	upload.to.bednark.com $FileSoftwareQuotes $FileIndex
}
function	vstories() { 
	title stories
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileStories` &)
	vici $FileStories $FileIndex
	upload.to.bednark.com $FileStories $FileIndex
}
function	vstrings() { 
	title violin strings survey
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileViolinStrings` &)
	vici $FileViolinStrings $FileIndex
	upload.to.bednark.com $FileViolinStrings $FileIndex
}
function	vvocab() { 
	title vocab
    cd $DirQuiz
	cd $DirBednarkCom
	(firefox file:///`cygpath -m $FileVocab` &)
	vici $DirQuiz/db_vocab $FileVocab $FileIndex
	upload.to.bednark.com $FileVocab $FileIndex
}


function getbednark.com() {
	rm -fr /tmp/bednark.com
	mkdir -p /tmp/bednark.com
	scp -p 'rob@bednark.com:/home/rob/bednark.com/docs/*html' /tmp/bednark.com
}
function upload.defaults.to.bednark.com() {
	upload.to.bednark.com $FileIndex $FileQuotes $FileAbout $FileBooknotes
}
function upload.to.bednark.com() {
	set -xv
	cd $DirBednarkCom
	scp -pr $@ 'rob@bednark.com:/home/rob/bednark.com'
	set +xv
}
function web() {
    action=$1
    (set -x;
     sudo service apache2 $action;
     sudo service nginx $action;
    )
}
function pgconfigs() {
    DirPostgres=/etc/postgresql/*/*
    vim $DirPostgres/pg_hba.conf $DirPostgres/postgresql.conf
}
function pglogs() {
    DirPostgres=/var/log/postgresql
    vim $DirPostgres/*
}
function webconfigs() {
    DirApache=/etc/apache2
    DirNginx=/etc/nginx
    DirPostgres=/etc/postgresql/*/*
    vim $DirApache/sites-enabled/* $DirApache/*.conf $DirNginx/*conf $DirNginx/sites-enabled/* $DirNginx/*params $DirPostgres/pg_hba.conf $DirPostgres/postgresql.conf
}
function weblogs() {
    DirApache=/var/log/apache2
    DirNginx=/var/log/nginx
    DirPostgres=/var/log/postgresql
    vim $DirNginx/error*log $DirNginx/access*log $DirApache/error*log $DirApache/other*log $DirPostgres/*
}

################################################################################
### Set's
################################################################################
### Set the command-line editing mode to "vi" (rather than the default of emacs)
set -o vi

################################################################################
# Other functions
################################################################################
function cpp.bednark.com() {
	cd $DirBednarkCom/cpp
	#tmpDirCppOutput="$DirBednarkCom/cpp.output"
	#mkdir -p $tmpDirCppOutput

	if [ $# -ge 1 ]; then
		allFiles="$*"
	else
		allFiles="*"
	fi;

	for oneFile in $allFiles; do
		# e.g., input: foo.cpp  output: foo.html
		fileOutput=`echo $oneFile | sed -e 's/cpp/html/g'`
		# cpp.include.file.py is a file that I wrote
		echo "Processing file [$oneFile]..."
		cpp.include.files.py $oneFile >  ../$fileOutput
	done
}
function firefoxfile() {
	title firefox $1
	echo "NOTE: this firefoxfile function only works for relative paths, not for absolute paths"
	set -x
	if echo $1 | grep '^/' > /dev/null 2>&1; then
		# This is an absolute path, because it starts with a "/"
		pathWin=`cygpath -m "$1"`
	else
		# This is a relative path, because it does not start with a "/"
        pwdNow=`pwd`
		pathWin=`cygpath -m "$pwdNow/$1"`
	fi
	echo $pathWin
	(firefox file:///"$pathWin" &)
	set +x
}
function ls.1.less() {
	echo 'e.g., ls.1.less foo (ls -1d *foo* | less)' > /dev/null
	ls -1d *$1* | less
}
function ls.newest.files() {
	echo "e.g., ls.newest.files 5 (shows the newest 5 files)" > /dev/null
	# Need to quote the filenames, in case they have spaces in them, like the chat logs do.
	number=${1:-20}
	files=`find * -type f -prune | xargs \ls -1dt | head -${number}`
	ls -ltrd $files
}
function python.module.dir() {
    python $DirLearn/get_module_path.py $*
}
function vi.git.grep() {
    vim $(git grep -l $*)
}
function vi.ls.head() {
	echo "e.g., vi.ls.head (edits the newest 5 files)" > /dev/null
	# Need to quote the filenames, in case they have spaces in them, like the chat logs do.
    number=5
	files=`find * -type f -prune | xargs \ls -1dt | head -${number}`
	vi $files
}
function vi.last.n.files() {
	echo "e.g., vi.last.n.files '*report' 10" > /dev/null
	pattern=$1
	number=$2
	# Need to quote the filenames, in case they have spaces in them, like the chat logs do.
	vi `ls -1t $pattern | head -$number`
	#files=""
	#for oneFile in `ls -1t $pattern | head -$number`; do
		#files="$files \"'\"$oneFile\"'\" " 
	#done
	#vi -R $files
}
function vi.files.with.pattern() {
	echo "e.g., vi.files.with.pattern 'FAILED' '*.runxml.log*' 10" > /dev/null
	patternGrep=$1
	patternFile=$2
	number=${3:-20}
	files=`\ls -1t $patternFile | xargs --no-run-if-empty grep -iIl "$patternGrep" /dev/null | head -${number}`
	vi -R $files
}
function vici.grep.i() {
    patternGrep=$1
    echo "Pattern=[$patternGrep]"
    files=`grep -iIl $patternGrep *`
    vici $files
}
function vi.grep.l() {
    # USAGE: vi.grep.l {grep_args}
    # vim all files in current dir that contain {grep_args}
    grepArgs="$*"
    echo "grep args=[$grepArgs]"
    if $MacOSX; then
        set -xv
        grep -Il $grepArgs | xargs vim
        set +xv
    else
        set -xv
        grep -Il $grepArgs | xargs --no-run-if-empty vim
        set +xv
    fi
}
function vi.grep.il() {
    # USAGE: vi.grep.il {grep_args}
    # vim all files in current dir that match "grep -i {grep_args}"
    patternGrep=$1
    echo "Pattern=[$patternGrep]"
    set -xv
    if $MacOSX; then
        grep -iIl $patternGrep * | xargs --no-run-if-empty vim
    else
        grep -iIl $patternGrep * | xargs vim
    fi
    set +xv
}
function vi.grep.ril() {
    # USAGE: vi.grep.ril {grep_args}
    # Vim all recursively found files that match "grep -rilI {grep_args}"
    patternGrep=$1
    echo "Pattern=[$patternGrep]"
    grep -rilI $patternGrep . | xargs vim

    # This one will only work with xargs that supports the --no-run-if-empty option:
    #grep -ril $patternGrep . | xargs --no-run-if-empty vim
}
function tail.recent.logs() {
    # Tail the newest 2 log files
    (set -xv; date; tail -30f $(ls -1tr ~/logs | head -n 2) )
}
function tail.newest.n.files() {
	echo "e.g., tail.newest.n.files 2 '*.log' > /dev/null" > /dev/null
	number=${1:-1}
	pattern=${2:-}
	#files=`\ls -1t | xargs --no-run-if-empty find -type d -prune | head -${number}`
	files=`find * -type f -prune | xargs \ls -1d | head -${number}`
	files2=""
	for oneFile in $files; do
		if [ -d $oneFile ]; then
			# skip directories
			:
		else
			files2="$files2 $oneFile"
		fi
	done
	tail -99f $files
}
function hg() {
    # hg = history | grep
	echo "e.g., histgrep foo" > /dev/null
    patternGrep="$1"
	history | egrep -i $patternGrep
}
function hgt() {
    # hgt = history | grep | tail
	echo "e.g., histgrep foo" > /dev/null
    patternGrep="$1"
	history | egrep -i $patternGrep | tail
}
function lsgrep() {
	echo "e.g., lsgrep foo" > /dev/null
    patternGrep="$1"
	ls -ld *"$patternGrep"*
}
function lshead() {
	#number=${1:-30}
	#ls -alt | head -$number
	where=$*
    ls -alt $where | head -10
}
function findExecutables() {
	filesExec=`find * -prune -type f -perm +111`
}
function make.expected.all() {
	set -x
	findExecutables
	../make.actual.expected $filesExec
	set +x
}
function vexec() {
	findExecutables
	vim $filesExec
}
function run.commands() {
	set -x
	/home/rbednark/bin/commands >> /home/rbednark/output/out.commands.out 2>&1 &
	vim -R /home/rbednark/output/out.commands.out
	set +x
}
function tab() {
  # I got this script from Howard, July 2012, for doing tabs in Mac Terminal.
  TITLE="$1"
  if [ "$1" == "-t" ]
  then
      TITLE="$2"
      shift
      shift
  fi

  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
      activate
      set frontIndex to index of the first window whose frontmost is true
      tell window frontIndex
        set title displays custom title of selected tab to true
        set custom title of selected tab to "$TITLE"
      end tell
      do script with command "$*" in window 1
    end tell
EOF
}

if hostname | grep -i $HOSTNAME_COMPUTER_MOOVEL > /dev/null; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    source /usr/local/bin/virtualenvwrapper.sh
elif ! $Atlatl; then
    # my Retina Mac
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
    [ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
    if echo $SHELL | grep zsh > /dev/null; then
        [ -f ~/.git.prompts.zsh ] && source ~/.git.prompts.zsh
    fi
fi

################################################################################
# nosetests autocomplete
# Note: need to "pip install nosecomplete" in the virt as well
################################################################################
if echo $SHELL | grep bash > /dev/null; then
    # bash

    # copied from newer versions of bash
    __ltrim_colon_completions() {
        # If word-to-complete contains a colon,
        # and bash-version < 4,
        # or bash-version >= 4 and COMP_WORDBREAKS contains a colon
        if [[ "$1" == *:* && (
                ${BASH_VERSINFO[0]} -lt 4 ||
                (${BASH_VERSINFO[0]} -ge 4 && "$COMP_WORDBREAKS" == *:*)
            )
        ]]; then
            # Remove colon-word prefix from COMPREPLY items
            local colon_word=${1%${1##*:}}
            local i=${#COMPREPLY[*]}
            while [ $((--i)) -ge 0 ]; do
                COMPREPLY[$i]=${COMPREPLY[$i]#"$colon_word"}
            done
        fi
    } # __ltrim_colon_completions()

    _nosetests()
    {
        cur=${COMP_WORDS[COMP_CWORD]}
        if [[ ${BASH_VERSINFO[0]} -lt 4 ||
              (${BASH_VERSINFO[0]} -ge 4 && "$COMP_WORDBREAKS" == *:*)
        ]]; then
            local i=$COMP_CWORD
            while [ $i -ge 0 ]; do
                [ "${COMP_WORDS[$((i--))]}" == ":" ] && break
            done
            if [ $i -gt 0 ]; then
                cur=$(printf "%s" ${COMP_WORDS[@]:$i})
            fi
        fi
        COMPREPLY=(`nosecomplete ${cur} 2>/dev/null`)
        __ltrim_colon_completions "$cur"
    }
    complete -o nospace -F _nosetests nosetests
fi

if echo $SHELL | grep zsh > /dev/null; then
    # zsh
    autoload -U compinit
    compinit

    autoload -U bashcompinit
    bashcompinit

    _nosetests()
    {
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=(`nosecomplete ${cur} 2>/dev/null`)
    }
    complete -o nospace -F _nosetests nosetests
fi

################################################################################
### end of nosetests completions
################################################################################

# Commented-out the following 2 lines Wed 3/5/14 2:30pm after upgrading to Mavericks, because MacVim (mvim) is giving a SEGV with command-t.
# It looks like this might be because of the Ruby version in my path.
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

######## Generated by Betty's install script
alias betty=/Users/rob/betty/main.rb

if echo $SHELL | grep bash > /dev/null; then
    # autocomplete for git for things like "git checkout my-branchname-some<tab>"
    source ~/.unix.config.files/git-completion.bash
fi
################################################################################
### The end. (.bashrc)
################################################################################

export NVM_DIR="/Users/robb/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
