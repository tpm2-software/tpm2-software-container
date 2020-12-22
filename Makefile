
TARGET_SUFFIX := .docker
SOURCE_SUFFIX := $(TARGET_SUFFIX).m4

SOURCES := $(wildcard *$(SOURCE_SUFFIX))
TARGETS := $(patsubst %$(SOURCE_SUFFIX),%$(TARGET_SUFFIX),$(SOURCES))

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	@rm -f $(TARGETS)

.PHONY: debug
debug:
	@echo "SOURCES: $(SOURCES)"
	@echo "TARGETS: $(TARGETS)"

%$(TARGET_SUFFIX) : %$(SOURCE_SUFFIX)
	m4 -s -Imodules $< > $@
