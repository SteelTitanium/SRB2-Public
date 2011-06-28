#Add-on Makefile for wxDev-C++ project file
ifdef ComSpec
COMSPEC=$(ComSpec)
endif
ifdef COMSPEC
OBJCOPY=objcopy.exe
OBJDUMP=objdump.exe
GZIP?=gzip.exe
else
OBJCOPY=objcopy
OBJDUMP=objdump
GZIP?=gzip
endif
DBGNAME=$(BIN).debug
OBJDUMP_OPTS?=--wide --source --line-numbers
GZIP_OPTS?=-9 -f -n
GZIP_OPT2=$(GZIP_OPTS) --rsyncable

all-after:
	$(OBJDUMP) $(OBJDUMP_OPTS) $(BIN) > $(DBGNAME).txt
	$(OBJCOPY) $(BIN) $(DBGNAME)
	$(OBJCOPY) --strip-debug $(BIN)
	$(OBJCOPY) --add-gnu-debuglink=$(DBGNAME) $(BIN)
ifdef COMSPEC
	-$(GZIP) $(GZIP_OPTS) $(DBGNAME).txt
else
	$(GZIP) $(GZIP_OPT2) $(DBGNAME).txt || $(GZIP) $(GZIP_OPTS) $(DBGNAME).txt
endif

