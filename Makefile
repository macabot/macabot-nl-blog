# Automatically find all directories inside submodules/ that have a Makefile
SUBMODULE_DIRS := $(dir $(wildcard submodules/*/Makefile))

.PHONY: all submodules clean $(SUBMODULE_DIRS)

# Default target: builds all submodules
all: submodules

# Delegate make execution to each submodule directory
submodules: $(SUBMODULE_DIRS)

$(SUBMODULE_DIRS):
	@echo "=== Building Submodule: $@ ==="
	@$(MAKE) -C $@

# Pass 'make clean' down to submodules
clean:
	@for dir in $(SUBMODULE_DIRS); do \
		echo "=== Cleaning Submodule: $$dir ==="; \
		$(MAKE) -C $$dir clean || true; \
	done
