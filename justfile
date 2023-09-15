# Variables
linter := "selene"
formatter := "stylua"
cwd := "."

lint:
	@echo "Running lint..."
	{{linter}} {{cwd}}

format:
	@echo "Running formatting tool..."
	{{formatter}} {{cwd}}

# vim: noexpandtab tabstop=4 shiftwidth=4 ft=make
