part of ng2_dart_modal

/**
 * Data definition
 */
//Todo: Check usage
class YesNoModalContent {
    YesNoModalContent(
        public title: string = 'Hello World Title',
        public body: string = 'Hello World Body!',
        public hideNo: boolean = false,
        public yesText: string = 'YES',
        public noText: string = 'NO'
    ) {}
}

/**
 * A 2 state bootstrap modal window, representing 2 possible answer, true/false.
 */
@Component(
    selector: 'modal-content',
    directives: [ NgIf ],
    template: '''
    	<div class="modal-header">
        	<h3 class="modal-title">{{context.title}}</h3>
        </div>
        <div class="modal-body">{{context.body}}</div>
        <div class="modal-footer">
            <button class="btn btn-primary" (click)="ok($event)">{{context.yesText}}</button>
            <button *ngIf="!context.hideNo" class="btn btn-warning" (click)="cancel()">{{context.noText}}</button>
        </div>
	'''
)

class YesNoModal implements ICustomModalComponent {
    ModalDialogInstance dialog;
    YesNoModalContent context;

    constructor(ModalDialogInstance dialog, ICustomModal modelContentData) {
        this.dialog = dialog;
        this.context = (YesNoModalContent)modelContentData;
    }

    YesNoModal ok($event) {
        $event.stopPropagation();
        this.dialog.close(true);
    }

    void cancel() {
        this.dialog.dismiss();
    }
}