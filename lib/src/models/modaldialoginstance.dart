part of ng2_dart_modal;

/**
 * API to an open modal window.
 */
class ModalDialogInstance {
    ComponentRef contentRef;
    /**
     * States if the modal is inside a specific element.
     */
    bool inElement;

    ModalConfig config;

    ComponentRef _bootstrapRef;
    ComponentRef _backdropRef;
    var _resultDeferred;

    ModalDialogInstance(this.config) {
        this._resultDeferred = new Completer();
    }

    set backdropRef(ComponentRef value) {
        this._backdropRef = value;
    }

    set bootstrapRef(ComponentRef value) {
        this._bootstrapRef = value;
    }

    /**
     * A Future that is resolved on a close event and rejected on a dismiss event.
     * @returns {Future<T>|any|*|Future<any>}
     */
    Future get result => this._resultDeferred.future;

    /**
     *  Close the modal with a return value, i.e: result.
     */
    void close({dynamic result: null}) {
        if (this.contentRef.instance.beforeClose()) return;
        this.dispose();
        this._resultDeferred.complete(result);
    }

    /**
     *  Close the modal without a return value, i.e: cancelled.
     *  This call is automatically invoked when a user either:
     *  - Presses an exit keyboard key (if configured).
     *  - Clicks outside of the modal window (if configured).
     *  Usually, dismiss represent a Cancel button or a X button.
     */
    void dismiss() {
        if (this.contentRef.instance.beforeDismiss()) return;
        this.dispose();
        this._resultDeferred.complete(false);
    }

    void dispose() {
        this._bootstrapRef.dispose();
        this._backdropRef.dispose();
        this.contentRef.dispose();
    }
}