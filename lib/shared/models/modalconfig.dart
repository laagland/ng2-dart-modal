part of schemas

ModalConfig _defaultConfig;

@Injectable()
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
     * Accepts either a single numeric value or an array of numeric values.
     * A modal closed by a keyboard stroke will result in a 'reject' notification from the promise.
     * Defaults to 27, set `null` implicitly to disable.
     */
	//keyboard: Array<number> | number;
    dynamic keyboard;

    ModalConfig(String size = 'lg', bool isBlocking = false,
                dynamic keyboard = [27]) {
        this.size = size;
        this.isBlocking = isBlocking;
        this.keyboard = keyboard;
    }

    /**
     * Makes a ModalConfig instance valdud.
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

_defaultConfig = new ModalConfig('lg', true, [27]);