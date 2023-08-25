fn symlink_vmodule() ! {
	module_path := '${home_dir()}/.vmodules/freeflowuniverse/freeflownation'
	if !exists(module_path) {
		symlink('${dir(@FILE)}/src', module_path)!
	}
}

symlink_vmodule()!
