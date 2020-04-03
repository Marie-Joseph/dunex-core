# DUNEX Core
DUNEX Core contains a collection of mostly POSIX compliant core utilities written in D.
At current time the implementations are more like the FreeBSD core utilities.

## Compiling ##

Either `dub build` to use dub or `./build.sh` to use meson.

## Done and Documented with a manpage but needs i18n ##

* dirname (1dunex)

## (Mostly) Done but needs documentation ##

* nl (missing a weird little feature but should be easy to implement)
* mkfifo
* ddate

## Done but needs porting to command framework ## 
* yes
* tee
* tty
* echo
* uname (this doesn't match Linux, but matches FreeBSD's implementation)
* hostid
* true / false (i called it "return" and it will work if you name it true, or false).
* sync
* basename
* tsort
* cut (extends functionality in useful ways that are substantially better than gnu version).
* unlink
* seq
* sleep
* su
* wc
* cat

## WIP ##

* uniq
* mkdir
* cksum (doesn't work - algorithm isn't standard and implementation isn't correct).
* su (Clipsey is doing that)
* factor (works for up to ulong length things but is a naive implementation that is slower than good implementations)
* hostname


## Todo ##

* See tickets in https://github.com/dunex-project/dunex-core/issues
* Man pages for everything in markdown format
* ... and anything else, see also: https://en.wikipedia.org/wiki/List_of_Unix_commands
* i18n using djtext most likely (only maintained i18n framework available) and translations
