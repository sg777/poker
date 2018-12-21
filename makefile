#if 0

######################
#                    #
#   pokeref          #
#                    #
#   by Paul Hsieh    #
#                    #
######################

APPNAME = poker
CDIR = .
ODIR = .\obj
ADIR = .\arc
CC  = *wcc386
CPP = *wpp386
DEVNULL = nul

SYSLFLAGS = SYS nt
SYSCFLAGS = -bt=nt

CFLAGS = -e25 -zq -otexan -mf -5r $(SYSCFLAGS) -bm -wx -we
CPPFLAGS = $(CFLAGS) -xs
DEFINES = 
INCLUDES = 

# Object files

OFILES = $(ODIR)\pokeref.obj $(ODIR)\main.obj

LIBS = 

# Makefile verbose setting

QUIET = @

.c: $(CDIR)
.cpp: $(CDIR)

# The default build rule for cpp -> obj creation.

.c.obj: .AUTODEPEND
	$(QUIET)echo     Compiling: $[*
	$(QUIET)$(CC) $[* $(INCLUDES) $(CFLAGS) $(DEFINES) -fo=$(ODIR)\

.cpp.obj: .AUTODEPEND
	$(QUIET)echo     Compiling: $[*
	$(QUIET)$(CPP) $[* $(INCLUDES) $(CPPFLAGS) $(DEFINES) -fo=$(ODIR)\


# The first rule is the default build rule, from which all other rules may be
# activated

$(APPNAME).exe : $(OFILES) makefile .AUTODEPEND
	$(QUIET)%write $(ODIR)\$(APPNAME).lnk NAME $(APPNAME).exe
	$(QUIET)%append $(ODIR)\$(APPNAME).lnk $(SYSLFLAGS) op m=$(ODIR)\$(APPNAME).map d all op st=16384 op maxe=25 op q op symf=$(ODIR)\$(APPNAME).sym op redefsok
	$(QUIET)for %%f in ($(OFILES)) do @%append $(ODIR)\$(APPNAME).lnk FIL %%f
	$(QUIET)for %%f in ($(LIBS)) do @%append $(ODIR)\$(APPNAME).lnk LIBRARY %%f
	$(QUIET)echo     Linking: $(APPNAME)
	$(QUIET)*wlink @$(ODIR)\$(APPNAME).lnk
	$(QUIET)echo.
	$(QUIET)echo     Target $(APPNAME).exe done.

# Non-default build rules.

# Initial commands invoked on every make

.BEFORE
	$(QUIET)!if not exist $(ODIR)\nul md $(ODIR)
	$(QUIET)echo xxx > $(ODIR)\xxx
	$(QUIET)if not exist $(ODIR)\xxx mkdir $(ODIR)
	$(QUIET)if exist $(ODIR)\xxx del $(ODIR)\xxx > $(DEVNULL)
	$(QUIET)echo     $(APPNAME)
	$(QUIET)echo     =======
	$(QUIET)set INCLUDE=.;$(%watcom)\h;$(%watcom)\h\nt
	$(QUIET)set DOS4G=QUIET

# User defined commands

clean: .SYMBOLIC
	$(QUIET)echo     Removing build targets
	$(QUIET)for %%f in ($(ODIR)\*.obj *.exe $(ODIR)\*.lnk $(ODIR)\*.map $(ODIR)\*.sym $(APPNAME).exe *.err) do @if exist %%f del %%f > nul

archive: .SYMBOLIC
	$(QUIET)echo Cleaning
	$(QUIET)echo ========
	$(QUIET)wmake /h clean
	$(QUIET)echo Various archive commands
	$(QUIET)echo ========================
	$(QUIET)!if not exist $(ADIR)\nul md $(ADIR)
	$(QUIET)echo xxx > $(ADIR)\xxx
	$(QUIET)if not exist $(ADIR)\xxx mkdir $(ADIR)
	$(QUIET)if exist $(ADIR)\xxx del $(ADIR)\xxx > $(DEVNULL)
 	$(QUIET)-pkzip -u $(ADIR)\$(APPNAME).zip *.* > $(DEVNULL)
	$(QUIET)-pkzip -u -p -r $(ADIR)\$(APPNAME).zip *.wpj > $(DEVNULL)
	$(QUIET)-pkzip -u -p -r $(ADIR)\$(APPNAME).zip *.tgt > $(DEVNULL)
	$(QUIET)-pkzip -v $(ADIR)\$(APPNAME).zip

#endif
