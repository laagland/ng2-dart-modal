part of ng2_dart_modal;

/**
 * Data definition
 */
//Todo: Check usage and port
class OKOnlyContent {
    String title = 'Hello World Title';
    String body = 'Hello World Body!';
    String okText = 'OK';

    OKOnlyContent();
}

/**
 * A 2 state bootstrap modal window, representing 2 possible answer, true/false.
 */
@Component(
    selector: 'modal-content',
    template: '''
    	<div class="modal-header">
        	<h3 class="modal-title">{{context.title}}</h3>
		</div>
    	<div class="modal-body">{{context.body}}</div>
        <div class="modal-footer">
            <button class="btn btn-primary" (click)="ok()">{{context.okText}}</button>
        </div>
	'''
)

class OKOnlyModal implements ICustomModalComponent {
    ModalDialogInstance dialog;
    OKOnlyContent context;

    OKOnlyModal(ModalDialogInstance dialog, ICustomModal modelContentData) {
        this.dialog = dialog;
        this.context = modelContentData as OKOnlyContent;
    }

    void ok() {
        this.dialog.close(result: true);
    }

    @override
    bool beforeClose() {
        return false;
    }

    @override
    bool beforeDismiss() {
        return false;
    }
}