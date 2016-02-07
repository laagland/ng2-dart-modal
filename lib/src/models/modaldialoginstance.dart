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
    var _resultDefered;

    ModalDialogInstance(this.config) {
		//Todo: Future?
        this._resultDefered = new Completer();
    }

    set backdropRef(ComponentRef value) {
        this._backdropRef = value;
    }
    set bootstrapRef(ComponentRef value) {
        this._bootstrapRef = value;
    }

    /**
     * A Promise that is resolved on a close event and rejected on a dismiss event.
     * @returns {Promise<T>|any|*|Promise<any>}
     */
	 //Todo: Future?
    Future get result => this._resultDefered.future;

    /**
     *  Close the modal with a return value, i.e: result.
     */
    void close({dynamic result: null}) {
		//Todo: first arg checks if method is implemented, not possible in Dart? See ICustomModalComponent in ModalDialogInstance
        if (this.contentRef.instance.beforeClose()) return;
        this.dispose();
		//Todo: Future?
        this._resultDefered.complete(result);
    }

    /**
     *  Close the modal without a return value, i.e: cancelled.
     *  This call is automatically invoked when a user either:
     *  - Presses an exit keyboard key (if configured).
     *  - Clicks outside of the modal window (if configured).
     *  Usually, dismiss represent a Cancel button or a X button.
     */
    void dismiss() {
		//Todo: first arg checks if method is implemented, not possible in Dart? See ICustomModalComponent in ModalDialogInstance
        if (this.contentRef.instance.beforeDismiss()) return;
        this.dispose();
		//Todo: Future?
//        this._resultDefered.reject();
//        this._resultDefered = null;
        this._resultDefered.complete(false);
    }

    void dispose() {
        this._bootstrapRef.dispose();
        this._backdropRef.dispose();
        this.contentRef.dispose();
    }
}