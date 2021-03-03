
TARGET_SUFFIX := .docker
SOURCE_SUFFIX := $(TARGET_SUFFIX).m4

SOURCES := $(wildcard *$(SOURCE_SUFFIX))
TARGETS := $(patsubst %$(SOURCE_SUFFIX),%$(TARGET_SUFFIX),$(SOURCES))
MODULES := $(wildcard modules/*.m4)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	@rm -f $(TARGETS)

.PHONY: debug
debug:
	@echo "SOURCES: $(SOURCES)"
	@echo "TARGETS: $(TARGETS)"
	@echo "MODULES: $(MODULES)"

%$(TARGET_SUFFIX) : %$(SOURCE_SUFFIX) $(MODULES)
	m4 -s -Imodules $< > $@
