part of ng2_dart_modal;

ModalConfig _config;

@Injectable()
class Modal {

    DynamicComponentLoader componentLoader;
    ApplicationRef appRef;
    Injector injector;
    ModalConfig defaultConfig;

    Modal(this.componentLoader, this.appRef, this.defaultConfig, this.injector) {

        // The Modal class should be an application wide service (i.e: singleton).
        // This will run once in most applications...
        // If the user provides a ModalConfig instance to the DI,
        // the custom config will be the default one.
        _config = (defaultConfig != null) ? ModalConfig.makeValid(defaultConfig) : new ModalConfig();
    }

    /**
     * Opens a modal window blocking the whole screen.
     * @param componentType The angular Component to render as modal.
     * @param bindings Resolved providers that will inject into the component provided.
     * @param config A Modal Configuration object.
     * @returns {Future<ModalDialogInstance>}
     */
    Future<ModalDialogInstance> open(dynamic componentType, List<ResolvedProvider> bindings, {ModalConfig config})  {
        ElementRef elementRef = injector.get(appRef.componentTypes[0]).elementRef;
        return this.openInside(componentType, elementRef, null, bindings, config: config);
    }

    /**
     * Opens a modal window inside an existing component.
     * @param componentType The angular Component to render as modal.
     * @param elementRef The element to block using the modal.
     * @param anchorName A template variable within the component.
     * @param bindings Resolved providers that will inject into the component provided.
     * @param config A Modal Configuration object.
     * @returns {Future<ModalDialogInstance>}
     */
    Future<ModalDialogInstance> openInside(dynamic componentType, ElementRef elementRef,
        String anchorName, List<ResolvedProvider> bindings, {ModalConfig config}) {

        config = (config != null) ? ModalConfig.makeValid(config, defaultConfig: _config) : _config;
        ModalDialogInstance dialog = new ModalDialogInstance(config);
        dialog.inElement = (anchorName != null);

        List<ResolvedProvider> dialogBindings = Injector.resolve([ provide(ModalDialogInstance, useValue: dialog) ]);

        return this.createBackdrop(elementRef, dialogBindings, anchorName: anchorName)
            .then( (ComponentRef backdropRef) {
                dialog.backdropRef = backdropRef;

                List<ResolvedProvider> modalDataBindings = new List.from(Injector.resolve(
                    [provide(ModalDialogInstance, useValue: dialog)]))
                    ..addAll(bindings);

                return this.componentLoader.loadIntoLocation(
                    BootstrapModalContainer, backdropRef.location, 'modalBackdrop', dialogBindings)
                    .then((bootstrapRef) {
                        dialog.bootstrapRef = bootstrapRef;
                        return this.componentLoader.loadIntoLocation(
                            componentType, bootstrapRef.location, 'modalDialog', modalDataBindings)
                            .then((contentRef) {
                                dialog.contentRef = contentRef;
                                return dialog;
                            });
                        }
                    );
            });
    }

    /**
     * Creates backdrop element.
     * @param {ElementRef} The element to block using the modal.
     * @param {ResolvedProvider[]} Resolved providers,
     *     must contain the ModalDialogInstance instance for this backdrop.
     * @param {string} An anchor name, optional.
     *     if not supplied backdrop gets applied next to elementRef, otherwise into it.
     * @returns {Future<ComponentRef>}
     */
    Future<ComponentRef> createBackdrop(ElementRef elementRef, List<ResolvedProvider> bindings,
        {String anchorName}) {

        return (anchorName == null) ?
            this.componentLoader.loadNextToLocation(ModalBackdrop, elementRef, bindings) :
            this.componentLoader.loadIntoLocation(ModalBackdrop, elementRef, anchorName, bindings);
        }
}