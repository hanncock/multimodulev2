void addModule(String moduleName, [Map<String, Widget>? screen]) {
// If the module doesn't exist yet
if (!moduleMenus.containsKey(moduleName)) {
selectedModule.value = moduleName;

    if (screen == null || screen.isEmpty) {
      print('No screen provided for new module: $moduleName');
      return;
    }

    moduleMenus[moduleName] = screen;
    final firstWidget = screen.values.first;

    selectedScreen.value = firstWidget;
    selectedsubScreen.value = firstWidget;

    print('Created new module: $moduleName');
} else {
// If module already exists
selectedModule.value = moduleName;

    final module = moduleMenus[moduleName]!;

    if (screen == null || screen.isEmpty) {
      // No new screen provided, use existing first one
      final fallback = module.values.first;
      selectedScreen.value = fallback;
      selectedsubScreen.value = fallback;
      print('Switched to existing module: $moduleName, sub: fallback');
    } else {
      final submoduleKey = screen.keys.first;
      final submoduleWidget = screen.values.first;

      if (!module.containsKey(submoduleKey)) {
        // Add new submodule
        module[submoduleKey] = submoduleWidget;
        moduleMenus[moduleName] = module; // trigger reactivity if needed
        print('Added new submodule $submoduleKey to $moduleName');
      } else {
        print('Submodule $submoduleKey already exists in $moduleName');
      }

      // Switch to the requested submodule
      selectedScreen.value = submoduleWidget;
      selectedsubScreen.value = submoduleWidget;

      print('Switched to submodule: $submoduleKey in $moduleName');
    }
}

print('Current selectedModule: $selectedModule, selectedsubScreen: $selectedsubScreen');
}
# multimodulev2
