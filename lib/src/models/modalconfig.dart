part of ng2_dart_modal;

ModalConfig _defaultConfig = new ModalConfig(size: 'lg', isBlocking: false, keyboard: [27]);

//@Injectable()
class ModalConfig {
    /**
     * Size of the modal.
     * 'lg' or 'sm' only.
     * NOTE: No validation.
     * Default to 'lg'
     */
    String size;

    /**
     * Describes if the modal is blocking modal.
     * A Blocking modal is not closable by clicking outside of the modal window.
     * Defaults to false.
     */
    bool isBlocking;

    /**
     * Keyboard value/s that close the modal.
     * Accepts either a single numeric value or a List of integer values.
     * A modal closed by a keyboard stroke will result in a 'reject' notification from the future.
     * Defaults to 27, set `null` implicitly to disable.
     */
    dynamic keyboard;

    ModalConfig({this.size: 'lg', this.isBlocking: false, this.keyboard: 27});

    /**
     * Makes a ModalConfig instance valid.
     * @param config
     * @param defaultConfig A Default config to use as master, optional.
     * @returns {ModalConfig} The same config instance sent.
     */
    static makeValid(ModalConfig config, {ModalConfig defaultConfig}) {
	
        defaultConfig = defaultConfig ?? _defaultConfig;

        if (config.size == null)
            config.size = defaultConfig.size;

        if (config.isBlocking != false)
            config.isBlocking = true;

        if (config.keyboard != null) {
            if (config.keyboard is List<int>) {
                config.keyboard = config.keyboard.length == 0
                    ? defaultConfig.keyboard : config.keyboard;
            } else if (config.keyboard is int) {
                config.keyboard = [config.keyboard];
            } else {
                config.keyboard = defaultConfig.keyboard;
            }
        }

        return config;
    }

}