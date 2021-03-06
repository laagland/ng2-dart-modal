part of ng2_dart_modal;

/**
 * A Type used as a binding key for dialog window Components
 */
class ICustomModal {
	ICustomModal();
}

abstract class ICustomModalComponent {
    ModalDialogInstance dialog;

    /**
     * Invoked before a modal is dismissed, return true to cancel dismissal.
     */
    bool beforeDismiss();

    /**
     * Invoked before a modal is closed, return true to cancel closing.
     */
    bool beforeClose();
}