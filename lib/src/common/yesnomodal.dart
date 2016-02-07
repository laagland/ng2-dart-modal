part of ng2_dart_modal;

/**
 * Data definition
 */
class YesNoModalContent {

    String title = 'Hello World Title';
    String body = 'Hello World Body!';
    bool hideNo = false;
    String yesText = 'YES';
    String noText = 'NO';

    YesNoModalContent(this.title, this.body, this.hideNo, {this.yesText: 'Yes', this.noText: 'No'});
}

/**
 * A 2 state bootstrap modal window, representing 2 possible answer, true/false.
 */
@Component(
    selector: 'modal-content',
    directives: const [CORE_DIRECTIVES],
    template: '''
    	<div class="modal-header">
        	<h3 class="modal-title">{{context.title}}</h3>
        </div>
        <div class="modal-body">{{context.body}}</div>
        <div class="modal-footer">
            <button class="btn btn-primary" (click)="ok(\$event)">{{context.yesText}}</button>
            <button *ngIf="!context.hideNo" class="btn btn-warning" (click)="cancel()">{{context.noText}}</button>
        </div>
	'''
)

class YesNoModal implements ICustomModalComponent {
    ModalDialogInstance dialog;
    YesNoModalContent context;

    YesNoModal(ModalDialogInstance dialog, ICustomModal modelContentData) {
        this.dialog = dialog;
        this.context = modelContentData as YesNoModalContent;
    }

    void ok($event) {
        $event.stopPropagation();
        this.dialog.close(result: true);
    }

    void cancel() {
        this.dialog.dismiss();
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