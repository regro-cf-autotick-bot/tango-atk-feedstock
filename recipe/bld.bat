setlocal EnableDelayedExpansion

call mvn versions:set versions:update-child-modules -DnewVersion=%PKG_VERSION% -DprocessAllModule -DgenerateBackupPoms=false -Prelease

REM Skip the tests because they require to have a tango database running
call mvn install -DskipTests

REM Generate third party license report
call mvn license:aggregate-third-party-report
copy target\site\aggregate-third-party-report.html .

mkdir "%PREFIX%\share\java"
copy assembly\target\JTango-%PKG_VERSION%.jar %PREFIX%\share\java\JTango.jar
copy widget\target\ATKWidget-%PKG_VERSION%.jar %PREFIX%\share\java\ATKWidget.jar
copy widget\target\ATKCore-%PKG_VERSION%.jar %PREFIX%\share\java\ATKCore.jar
