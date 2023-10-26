# Makefile for running static analysis tools

# Variables
LINT_TOOL = selene
FORMAT_TOOL = stylua

# Files
HERE = .

# Targets
.PHONY: all lint format

all: lint format check

lint:
	@echo "Running lint..."
	$(LINT_TOOL) $(HERE)

format:
	@echo "Running formatting tool..."
	$(FORMAT_TOOL) $(HERE)
	shfmt -i 4 -w -ci -s -bn ./bootstrap.sh

# vim: noexpandtab tabstop=4 shiftwidth=4
