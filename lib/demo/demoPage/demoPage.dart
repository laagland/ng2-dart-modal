part of ng2_dart_modal_demo;

@Component(
    selector: 'demo-page',
    directives: const [SampleElement],
    providers: const [Modal],
    styleUrls: const ['demo/demoPage/demoPage.css'],
    templateUrl: 'demo/demoPage/demoPage.html'
)

class DemoPage {
    ElementRef mySampleElement;
    String lastModalResult;

    Modal modal;
    ElementRef elementRef;
    Injector injector;
    Renderer _renderer;

    DemoPage(this.modal, this.elementRef, this.injector, this._renderer);

    // We defaulted quit key to 81 at app bootstrap, to make it 27 we have to specify it for each modal config
    static Map<String, ModalConfig> modalConfigs = {
        'large': new ModalConfig(size: "lg", keyboard: 27),
        'small': new ModalConfig(size: "sm", keyboard: 27),
        'yesno': new ModalConfig(size: "sm", keyboard: 27),
        'key': null, // Modal will use default config, which we set at app bootstrap (setting in app bootstrap is optional)
        'blocking': new ModalConfig(size: "lg", isBlocking: true, keyboard: null), // null for keyboard means no keyboard keys can close the modal.
        'inElement': new ModalConfig(size: "lg", isBlocking: true, keyboard: null),
        'customWindow': new ModalConfig(size: "lg", isBlocking: true, keyboard: 27)
    };

    static Map<String, ModalConfig> modalData = {
        'large': new YesNoModalContent('Simple Large modal', 'Press ESC or click OK / outside area to close.', true),
        'small': new YesNoModalContent('Simple Small modal', 'Press ESC or click OK / outside area to close.', true),
        'yesno': new YesNoModalContent('Simple 2 button custom modal', 'Answer the question', false, yesText: "Yes", noText: "No"),
        'key': new YesNoModalContent('Special Exit Key', 'Press q to close.', true),
        'blocking': new YesNoModalContent('Simple Blocking modal', 'You can only click OK to close this modal.', true),
        'inElement':new YesNoModalContent('Simple In Element modal', 'Try stacking more modals, click OK to close.', true),
        'customWindow': new AdditionCalculateWindowData(2, 3)
    };
    /* tslint:enable */

    void openDialog(String type) {
        Future<ModalDialogInstance> dialog;
        var component = (type == 'customWindow') ? AdditionCalculateWindow : YesNoModal;

        // Workaround for https://github.com/angular/angular/issues/4330
        // providing resolved providers to IterableDiffers, KeyValueDiffers & Renderer.
        // Since customWindow uses 'ngClass' directive & 'ngClass' requires the above providers we need to supply them.
        // One would expect angular to get them automatically but that not the case at the moment.
        List<ResolvedProvider> bindings = Injector.resolve([
            provide(ICustomModal, useValue: DemoPage.modalData[type]),
            provide(IterableDiffers, useValue: this.injector.get(IterableDiffers)),
            provide(KeyValueDiffers, useValue: this.injector.get(KeyValueDiffers)),
            provide(Renderer, useValue: this._renderer)
        ]);

        if (type == 'inElement') {
            dialog = this.modal.openInside(
                component,
                this.mySampleElement,
                'myModal',
                bindings,
                config: DemoPage.modalConfigs[type]);
        } else {
            dialog = this.modal.open(
            component,
            bindings,
            config: DemoPage.modalConfigs[type]);
        }


        dialog.then((resultFuture) {
            return resultFuture.result.then(
                (result) {
                    if (result) {
                        this.lastModalResult = result;
                    } else {
                        this.lastModalResult = 'Rejected!';
                    }
                }
            );
        });
    }
}
