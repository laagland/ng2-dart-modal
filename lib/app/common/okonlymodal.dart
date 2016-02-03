part of ng2_dart_modal

/**
 * Data definition
 */
//Todo: Check usage and port
class OKOnlyContent {
    OKOnlyContent(
        public title: string = 'Hello World Title',
        public body: string = 'Hello World Body!',
        public okText: string = 'OK'
    ) {}
}

/**
 * A 2 state bootstrap modal window, representing 2 possible answer, true/false.
 */
@Component({
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
})

class OKOnlyModal implements ICustomModalComponent {
    ModalDialogInstance dialog;
    OKOnlyContent context;

    OKOnlyModal(ModalDialogInstance dialog, ICustomModal modelContentData) {
        this.dialog = dialog;
        this.context = (OKOnlyContent) modelContentData;
    }

    void ok() {
        this.dialog.close(true);
    }
}