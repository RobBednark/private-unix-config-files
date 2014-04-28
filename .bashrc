# Last updated: Fri 8/12/2002 06:15pm by Rob Bednark
# AUTHOR: Rob Bednark
################################################################################
### .bashrc
################################################################################

################################################################################
# oh-my-zsh BEGIN
################################################################################
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

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

################################################################################
# oh-my-zsh END
################################################################################

# Set the interactive shell prompt to [username@machinename directory]
if echo $SHELL | grep bash > /dev/null; then
    export PS1="\u@\h \w \D{%m/%d} \t$ "
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
    # If this shell doesn't support setopt (like bash), then do nothing.
    :
fi

# Show all lines of history, not just the last 15 lines.
alias history="history 1"
alias hless="history|less"
alias htail="history|tail"

if type bindkey > /dev/null 2>&1; then
    # bind control-r to be the history search 
    bindkey '^R' history-incremental-search-backward
fi

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
export SAVEHIST=30000 # masx size in HISTFILE
if echo $SHELL | grep zsh > /dev/null; then
    # Added 2/8/13.  History was not getting saved on Atlatl Mac.  Not sure how it was getting saved on my Retina.
    export HISTFILE=~/.zsh_history
    export HISTSIZE=32000 # max size internal history per session
fi
#export SHARE_HISTORY=1
# Uncommented APPEND_HISTORY 2/5/13
export APPEND_HISTORY=1 # Append rather than replace
#export INC_APPEND_HISTORY=1  

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

DirDropbox=~/Dropbox
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

DirBackup="$DirTopPC/backup"
DirBednarkCom="$DirTopPC/dropbox/Rob/bednark.com"
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
DirQuiz="$DirLearn/quiz.python/db"
DirReadOnly="$DirRbednark/read.only"
DirSync="$DirRbednark/sync"
DirUnixConfigFiles="$DirDropbox/Rob/unix.config.files"

BinQuote="$DirBin/get.random.quote.pl"

FileAbout="$DirBednarkCom/cpp/aboutMe.cpp"
FileAccomps="$DirDoc/accomplishments.txt"
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
FileJTmp="$DirDoc/j.interim.txt"
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
alias   cdatl="cd ~/Dropbox/git/atlatl-mvp/atlatl-server"
alias   cdcore="cd $DirDropbox/git/dart-core/atlatl-server"
alias   cdtest="cd $DirDropbox/git/dart-core/acceptance-tests/cuke-atlatl"
alias   show_data="python -u manage.py show_data |& less"
alias   ssh.dev.app="ssh -i ~/.ssh/DEVapp.pem rbednark@devapp.atlatlprivate.com"
alias   ssh.dev.db="ssh -i ~/.ssh/DEVdb.pem masteradmin@devdb.atlatlprivate.com"
alias   ssh.dev.web="ssh -i ~/.ssh/DEVweb.pem rbednark@devweb.atlatlprivate.com"
alias   ssh.prod.app="ssh -i ~/.ssh/PRODapp1.pem rbednark@prodapp1.atlatlprivate.com"
alias   ssh.prod.db="ssh -i ~/.ssh/PRODdb1.pem rbednark@proddb1.atlatlprivate.com"
alias   ssh.prod.web="ssh -i ~/.ssh/PRODweb1.pem rbednark@prodweb1.atlatlprivate.com"
#alias   atlatl.run.unit.tests="cdcore; workon atlatl; (set -x; ./manage.py test --testrunner=django.test.simple.DjangoTestSuiteRunner --settings=unit_test_settings main organization account quote rest_api customer lockout configuration api)"
#alias   atlatl.run.unit.tests="cdcore; python -u manage.py test --testrunner=django.test.simple.DjangoTestSuiteRunner --settings=unit_test_settings main organization account quote rest_api customer lockout configuration api"
alias   atlatl.run.unit.tests="cdcore; python -u manage.py test --testrunner=django.test.simple.DjangoTestSuiteRunner --settings=unit_test_settings account api configuration customer freight main native organization poc quote rest_api lockout"
alias   atlatl.coverage="coverage run atlatl-server/manage.py test account api configuration customer freight main native organization poc quote rest_api lockout --settings=unit_test_settings"
function   atlatl.recreate.db.only() {
    cdcore
    set -x
    find . -name '*.pyc' -delete
    dropdb -U atlatl atlatl
    if createdb -U atlatl atlatl; then
        time ./manage.py syncdb --migrate --noinput
        return 0
    else
        echo "ERROR from createdb; see above"
        return 1
    fi
}
function   atlatl.recreate.db.only2() {
    set -x
    find . -name '*.pyc' -delete
    dropdb -U atlatl atlatl2
    if createdb -U atlatl atlatl2; then
        time ./manage.py syncdb --migrate --noinput
        return 0
    else
        echo "ERROR from createdb; see above"
        return 1
    fi
}
function atlatl.create.db.data() {
    time ./manage.py make_test_data --email-domain=bednark.com --num-clients=1 --num-levels=0 --num-configs=1 --num-parts=1 --num-quotes=1 --num-sub-orgs=0 --num-users=1
}
function   atlatl.recreate.db.data.and.runserver() {
    start=$(date)
    if atlatl.recreate.db.only; then
        atlatl.create.db.data
        ./manage.py runserver
    fi
}
function   atlatl.recreate.db.data.and.runserver2() {
    start=$(date)
    if atlatl.recreate.db.only2; then
        atlatl.create.db.data
        ./manage.py runserver 8002
    fi
}
function atlatl.curl.wirecrafters.login() {
    (
    set -xv;
    curl --verbose --data 'email=wc.sales.rep@bednark.com&password=p' http://wirecrafters.dev.atlatlprivate.com/api/account/login/
    )
}
################################################################################
### Aliases
################################################################################
#alias acrobat="'/cygdrive/c/Program Files/Adobe/Acrobat 6.0/Reader/AcroRd32.exe'"
#alias acrobat="'/cygdrive/c/Program Files/Adobe/Acrobat 7.0/Reader/AcroRd32.exe'"
alias acrobat="'/cygdrive/c/Program Files (x86)/Adobe/Reader 10.0/Reader/AcroRd32.exe'"

alias   browse.family.tree="firefoxfile $FileFamilyTreeHtml"

alias	cdbednarkcom="cd $DirBednarkCom"
alias   cdbuddyup="cd $DirGitLocal/buddyup.github.adevore"
#alias	cdc="cd $DirC; pwd; ls"
#alias	cdcheckin="cd $DirCheckin"
alias   cddada="cd $DirDropbox/Rob/dada"
alias   cd.iphone.apps="cd ~/Music/iTunes/iTunes?Media/Mobile?Applications"
alias   cddjango="cd ~/dropbox/bin/learn/dir.learn.django.projects"
alias   cddjangocode="cd /home/sara/local.dir.learn.django.projects/my.venv/lib/python2.7/site-packages/django"
alias	cddoc="cd $DirDoc"
alias	cddownload="cd $DirDownload"
alias   cddropbox="cd ~/dropbox"
alias   cdebento="cd ~/dropbox/ebento/git/eBento1-Client-test/ebtest; ls"
alias   cdfam="cd ~/dropbox/family.tree/docs.July.1.Fri"
alias   cdgit="cd $DirGit"
alias	cdlearn="title learn; cd $DirLearn"
alias   cdlearngit="cd $DirLearn/git"
#alias	cdmusic="cd /cygdrive/c/Documents\ and\ Settings/All\ Users/Documents/My\ Music/"
#alias	cdoption="cd $DirOptionTables"
alias	cdpicts="cd $DirPicts"
alias   cdpsu="cd $DirDropbox/Rob/psu.online.map"
alias	cdpublic="cd $DirPublicHtml"
alias   cdpydoc="cd ~/dropbox/Rob/python.doc/python-2.7.2-docs-text"
alias   cdquiz="title quiz; cd $DirLearn/quiz.python/db"
alias   cdquizme="cd $DirGit/quizme_website"
alias	cdsel="title ebento.py; cd ~/huawei/selenium"
#alias	cdstax="cd $DirLearn/stax; pwd; ls"
alias   cdsurvey="cd $DirDropbox/mike.ames.survey/"
alias	cdsync="cd $DirSync"
#alias	cdtestadm="cd $DirTestadm; ls"
alias	cdtxt="cd $DirTxt"
alias   cdunixconfigfiles="cd $DirUnixConfigFiles"
alias   cdvagrant="cd ~/Desktop/vagranttest"
#alias   cdvim="cd '/cygdrive/c/Program Files (x86)/Vim/vim72/doc'"

################################################################################
# Trapit:
################################################################################
DirTrapitRepos="~/trapit.repos"
alias   cdarcher="cd $DirTrapitRepos/archer"
alias   cdelzar="cd $DirTrapitRepos/elzar"
alias   cdmom="cd $DirTrapitRepos/mom"
alias   cdnibbler="cd $DirTrapitRepos/nibbler"
alias   cdstorytool="cd $DirTrapitRepos/storytool"
alias   cdtrapit.vagrant="cd ~/vagrants/trapit.hashicorp.precise64" # trapit
alias   cdtrapit.repos="cd ~/vagrants/trapit.hashicorp.precise64/trapit.repos" # trapit
alias   cdzoidberg="cd $DirTrapitRepos/zoidberg"
alias   ssh.trapit="cdtrapit.vagrant; vagrant ssh"

################################################################################
# Tixie:
################################################################################
PemRobKey=$DirDropbox/Rob/aws/RobKey.pem
MachineRobAWS='ec2-23-20-227-24.compute-1.amazonaws.com'
DirTixieGit=~/git/tixie-web
DirTixieSrc=$DirTixieGit/src
DirTixieApps=$DirTixieSrc/apps
DirTixieRob=~/Dropbox/Rob/tixie
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
alias   cddropbox.tixie="cd ~/dropbox/Rob/tixie; ls"
alias   cdtixie="cd ~/Dropbox/git/tixie-web"
alias   cdtixierob="cd $DirTixieRob; ls"
alias   cdwebapp="cd /var/webapp/tixie_public"
#alias   subl.django="subl ~/.virtualenvs/tixie-web/lib/python2.7/site-packages/django/"
alias   subl.tixie="subl /Users/rob/git/tixie-web/src"
################################################################################

alias	ci="ci -zLT"
# I think "cmd" works for the default cygwin window, but not for rxvt
#alias	cls="cmd /c cls"
# The following echo sequence works for rxvt.
alias cls="echo -ne '\033c'" 
alias	co="co -zLT"
alias	cp="cp -ip "
# Set the Littred CPU to the slowest setting.
alias   cpuslow="cpushow; set -x; sudo cpufreq-set --cpu 1 --max 1200000;sudo cpufreq-set --cpu 0 --max 1200000; cpushow; set +x"
alias   cpufast="cpushow; set -x; sudo cpufreq-set --cpu 1 --max 2000000;sudo cpufreq-set --cpu 0 --max 2000000; cpushow; set +x"
alias   cpushow="set -x; cpufreq-info | egrep 'policy'; cpufreq-info|egrep stats; echo 'CRITICAL temp: 100C; MAX temp: 105C; Hard disk MAX temp: 140C; Hard disk MTBF: 500,000 hrs'; set +x"

alias	diffbednarkcom="diff -r $DirBednarkCom /tmp/bednark.com"
alias	dotrc="source $FileRc"

alias   finddropboxconflicted='find $DirDropbox | grep conflicted'
alias	findex="ls -l | grep '^...x'"
if uname | grep -i linux > /dev/null; then
	true
elif $MacOSX; then
    alias chrome="open -a Google\ Chrome"
	#alias	firefox="open /Applications/"
    :
else
	alias	firefox="/cygdrive/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe"
fi

# git aliases
alias   gb="echo git branch; git branch"
alias   gc="echo git checkout $*; git checkout"
alias   gf="echo git fetch; git fetch"
alias   git.log="(set -x; git log --all --graph --oneline --abbrev-commit  --decorate; set +x)"
#alias   git.diff.old="(set -x; git difftool  --ignore-submodules=dirty --extcmd=diff --noprompt $*)"

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
alias   mycmd='(set -x; rm -f mydb.db;./manage.py syncdb --noinput; ./manage.py mycmd)'
alias   mycmd.nosync='(set -x; ./manage.py mycmd)'

alias 	mounttestadm="sudo mkdir -p /testadm; sudo mount $MachineCurtis:/testadm /testadm"

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
alias   ssh.rob-aws="ssh -i $PemRobKey ubuntu@$MachineRobAWS"

# Tixie machines
alias   ssh.weechat=ssh.rob-aws
alias   ssh.dev-rob-admin-clone-20120723="ssh -i $PemTixie515 ubuntu@$MachineDevRobAdminClone20120723"
alias   ssh.dev-rob-db-pg9-12.04-20120717="ssh -i $PemTixie515 ubuntu@$MachineDevRobPg9_12_04_20120717"
alias   ssh.dev-rob-db-pg9-12.04-20120727="ssh -i $PemTixie515 ubuntu@$MachineDevRobPg9_12_04_20120727"
alias   ssh.dev-rob-db-pg9-20120712="ssh -i $PemTixie515 ubuntu@$MachineDevRobDbPg9_20120712"
alias   ssh.dev-rob-db-pg9-20120727="ssh -i $PemTixie515 ubuntu@$MachineDevRobDbPg9_20120727"
alias   ssh.dev-rob-db-clone-20120720="ssh -i $PemTixieKey ubuntu@$MachineDevRobDbClone20120720"
alias   ssh.dev-rob-db-clone-20120720-clone2-20120724="ssh -i $PemTixieKey ubuntu@$MachineDevRobDbClone20120720Clone20120724"
alias   ssh.dev-rob-db-clone-20120727="ssh -i $PemTixie515 ubuntu@$MachineDevRobDbClone20120727"
alias   ssh.dev-rob-rest-clone-20120723="set -x; ssh -i $PemTixie515 ec2-user@$MachineDevRobRestClone20120723; set +x"
alias   ssh.dev-rob-web-clone-20120626="ssh -i $PemTixie515 ubuntu@$MachineDevRobWebClone20120626"
alias   ssh.dev-rob-web-clone-20120719="ssh -i $PemTixie515 ubuntu@$MachineDevRobWebClone20120719"

alias   ssh.corp.tixie="ssh -i $PemTixie515 ubuntu@$MachineCorpTixie"
alias   ssh.prod-admin="ssh -i $PemTixieKey ubuntu@$MachineProdAdmin"
alias   ssh.prod-cron="ssh -i $PemTixieKey ubuntu@$MachineProdCron"
alias   ssh.prod-db="ssh -i $PemTixie515 ubuntu@$MachineProdDb"
alias   ssh.prod-db-01="ssh -i $PemTixieKey ubuntu@$MachineProdDb01"
alias   ssh.prod-db-8.4="ssh -i $PemTixieKey ubuntu@$MachineProdDb84"
alias   ssh.prod-web="ssh -i $PemTixie515 ubuntu@$MachineProdWeb"
alias   ssh.qa-iphone-api="ssh -i $PemTixie515 ubuntu@$MachineQAiPhoneAPI"
alias   ssh.qa-web.tixie="ssh -i $PemTixieKey ubuntu@$MachineQATixie"
alias   ssh.qa-db.tixie="ssh -i $PemTixieKey ubuntu@$MachineQA_DB_Tixie"

alias   source.django="source ~/dropbox/bin/learn/dir.learn.django.projects/source.venv"
alias   stree="open -a SourceTree"

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
alias	vconvert="title teamroom.how.to.convert.to.flexsan.html; cd $DirDoc; explorer.exe teamroom.how.to.convert.to.flexsan.html; vici teamroom.how.to.convert.to.flexsan.html"
alias	vebento="cdsel; vici ebento.py"
alias 	vhw="title Huawei; vici $FileToDo $FileHuawei $FileJ $FileDoc"
alias	vgoserver="title teamroom.design.proposal.eliminating.GoServer.html; cd $DirDoc; explorer.exe teamroom.design.proposal.eliminating.GoServer.html; vici teamroom.design.proposal.eliminating.GoServer.html"
alias	vgtest="title gtest.html; cd $DirDoc; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/teamroom.brownbag.gtest.html` &); vici teamroom.brownbag.gtest.html"

alias	vhowtorun="vici $DirDoc/teamroom.how.to.run.html"
alias	vninja="title ninja.html; cd $DirDoc; (firefox file:///`type cygpath > /dev/null 2>&1 && cygpath -m $DirDoc/ninja.html` &); vici ninja.html"
alias	vobs="title readme.obs.html; cd $DirDoc; explorer.exe readme.obs.html; vici readme.obs.html"
alias	vi=vim

alias 	vj.other="vici $FileJTmp $FileToDo $FileDiary $FileHuawei"
alias 	vj="title j; vim -R $FileJ ; echo vici $FileJTmp $FileToDo $FileDiary $FileHuawei"
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
alias   vachievements.atlatl="title vachievements.atlatl; vici $DirQuiz/achievements.atlatl"
alias   vapps="title vapps; cd $DirQuiz; vici db_apps"
alias   varchitecture="vici $DirQuiz/db_software_design_architecture"
alias   vatlatl="title vatlatl; vici $DirQuiz/db_atlatl"
alias   vdaily="title vdaily; cd $DirQuiz; vici db_daily_review"
alias   vdiary="title vdiary; cd $DirQuiz; vici db_diary"
alias   vdjango="title vdjango; cd $DirQuiz; vici db_django"
alias   vfamily="cdfam; vim -R *txt"
alias   vfun="cd $DirQuiz; vici db_fun"
alias   vgit="title vgit; cd $DirQuiz; vici db_git"
alias   vgratitude="cd $DirQuiz; vici gratitude"
alias   vinterview="cd $DirQuiz; vici db_interview_questions"
alias   viphone="cd $DirQuiz; vici *iphone*"
alias   vjavascript="cd $DirQuiz; vici db_javascript"
alias   vjournaling="cd $DirQuiz; vici db_journaling"
alias   vlearn="cd $DirQuiz; vici db_learn"
alias   vmac="title vmac; cd $DirQuiz; vici db_mac"
alias   vmisc="cd $DirQuiz; vici db_misc"
alias   vprogramming="cd $DirQuiz; vici db_programming"
alias   vpython="title vpython; cd $DirQuiz; vici db_python"
alias   vquiz="cd $DirQuiz; vici *xie *nix *apps *thon *ogy"
alias   vquizme="cd $DirGit/quizme_website; vici README"
alias   vresume="vici $DirQuiz/db_resume"
alias   vtalks="vici $DirQuiz/db_talks"
alias   vsql="title vsql; cd $DirQuiz; vici db_sql"
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
alias   vspinosa="vici $DirDoc/spinosa.property.values.txt"
alias vstocks="vici $FileStocks $FileStockNotes"
alias	vpsych="vici $FileMyPsychology"
alias vtoday="title vtoday; vici  $FileAccomps $FileDoc"
alias vtower="title vtower; vici $DirDoc/tower.hill.property.values.txt"
alias vtodo="title ToDo; vici  $FileTodayNew $FileToday"
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
    (set -x; python -u ~/Dropbox/bin/learn/pg.show.all.data.all.tables.py | egrep -i --context=6 "^\+|$regex" )
}
function psql.dev-rob-pg9-12.04-show-all-data() {
    (set -x; python -u ~/Dropbox/bin/learn/pg.show.all.data.all.tables.py)
}
function psql.dev-rob-pg9-12.04-select-events() {
    (set -x; psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM v_allevents_and_draws ORDER BY event_date' )
}
function psql.dev-rob-pg9-12.04-20120727() {
    (set -x; psql --host $MachineDevRobPg9_12_04_20120727 --port 5432 --user tixie_admin --dbname tixie_main )
}
function psql.dev-rob-pg9-12.04() {
    (set -x; psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main )
}
function psql.PROD-DB() {
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main $* )
}
function psql.vagrant() {
    (set -x; psql --host localhost --port 5433 --user tixie_admin --dbname tixie_main )
}
function psql.qa-db() {
    (set -x; date; psql --host $MachineQADb --port 5432 --user tixie_admin --dbname tixie_main )
}
function psql.list-tables.rob-dev-pg9() {
    (set -x; date; psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main --command '\d')
}
function psql.list-users.rob-dev-pg9() {
    (set -x; date; psql --host $MachineDevRobPg9_12_04_20120717 --port 5432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY username;')
}
function psql.list-users.PROD-DB() {
(set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT au.join_date, au.username, au.first_name, au.last_name, au.email, aa.dob, aa.tokens, aa.win_eligible, au.is_staff, au.is_superuser FROM accounts_account aa, auth_user au WHERE au.id = aa.user_id ORDER BY au.join_date;')
    #(set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY username;')
    #(set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT id,guid,user_id,facebook_id,access_token,avatar,site_password_set,email_notifications,facebook_wall_notifications FROM accounts_account ORDER BY id;')
}
function psql.list-users.date_joined.PROD-DB() {
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY date_joined;')
}
function psql.list-users.last_login.PROD-DB() {
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM auth_user ORDER BY last_login;')
}
function psql.list-hot-events.PROD-DB() {
    date
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM v_hot_analysis ORDER BY hotscore;')
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM vw_hot_events  ORDER BY uk_bid_cnt_by_event;')
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command 'SELECT * FROM vw_hot_events2 ORDER BY uk_bid_cnt_by_event;')
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command '\d+ v_hot_analysis')
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command '\d+ vw_hot_events')
    (set -x; date; psql --host $MachineProdDb --port 6432 --user tixie_admin --dbname tixie_main --command '\d+ vw_hot_events2')
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
    set -x
    scp -i $PemTixie515 $file $server:/tmp
    set +x
}
function scp.latest.dump() {
    set -x
    scp -i $PemTixie515 ubuntu@$MachineProdDb:/var/lib/postgresql/backups/hourly/tixie_main.dump.1 ~/Desktop/vagranttest
    set +x
}
function scp.get.tixie.reports() {
    set -x
    scp -C -i $PemTixie515 ubuntu@$MachineProdDb:/var/lib/postgresql/'*.csv' $DirTixieRob/reports
    set +x
}
function scp.to.rob-dev() {
    set -x
    scp -i $PemTixie515 $@ ubuntu@$MachineDevRobWebClone20120626:/tmp
    set +x
}
function scp.from.rob-dev() {
    set -x
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
    set -xv
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
  (set -x; git difftool  --ignore-submodules=dirty --extcmd=diff --noprompt $*)
}

function grepaliases () {
	grep -i $@ $FileEmailAddrs
}
function pless() {
    # pipe stdout/stderr to less
    $@ 2>&1 | less
}
function ninja.grep.tests () {
	egrep -v 'CleanupClient|GoServer|GoMake|InstallMDS|win_cleanup|^\+----------' $@ 
}
function phone () {
  grep -i $@ $FilePhone
}
function ping.monitor() {
    FILE_PING_OUTPUT=/tmp/ping.monitor.$$
    python -u ~/Dropbox/bin/learn/log_track_monitor_online_wifi_status_with_ping.py >>& $FILE_PING_OUTPUT &
    tail -f $FILE_PING_OUTPUT
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

function title {
    _title="$*"
    if $MacOSX; then
        # iTerm2 
        #echo -n "\033];$title\007"
        echo -ne "\033]0;"$_title"\007"
    else
        echo -ne "\e]2;$*\a"
    fi
}

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
    DirCurDir=$(pwd)
    DirBase=`dirname $onefile`

    # Go to the top level of the repo to add all files that haven't been added
    cd $DirBase
    pwd
    DirGit=$(git rev-parse --show-toplevel)
    cd $DirGit
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

    # setopt shwordsplit causes zsh to behave like bash for splitting a string (e.g., $files)
    setopt shwordsplit

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
	vici  $DirQuiz/*people
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
	vi -R `ls -1t $pattern | head -$number`
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
	echo "e.g., ls.head 40" > /dev/null
	#number=${1:-30}
	#ls -alt | head -$number
	where=$*
    ls -alt $where | head -30
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

if ! $Atlatl; then
    # my Retina Mac
    # For my Atlatl Mac, 
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
    [ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
    if echo $SHELL | grep zsh > /dev/null; then
        [ -f ~/.git.prompts.zsh ] && source ~/.git.prompts.zsh
    fi
fi

################################################################################
### The end.
################################################################################

# Commented-out the following 2 lines Wed 3/5/14 2:30pm after upgrading to Mavericks, because MacVim (mvim) is giving a SEGV with command-t.
# It looks like this might be because of the Ruby version in my path.
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
