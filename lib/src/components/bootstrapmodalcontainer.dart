part of ng2_dart_modal;

/**
 * A component that acts as a top level container for an open modal window.
 */
@Component(
    selector: 'bootstrap-modal',
    host: const {
        'tabindex': '0',
        'role': 'dialog',
        'class': 'in modal',
        'style': 'display: block',
        '[style.position]': 'position',
        '(body:keydown)': 'documentKeypress(\$event)',
        '(click)': 'onClick()'
    },
    
    template: '''
    <div class="modal-dialog"
         [class.modal-lg]="dialogInstance.config.size == \'lg\'"
         [class.modal-sm]="dialogInstance.config.size == \'sm\'">
         <div class="modal-content" (click)="onContainerClick(\$event)" style="display: block">
            <div style="display: none" #modalDialog></div>
         </div>
    </div>
    '''
)

class BootstrapModalContainer {
    ModalDialogInstance dialogInstance;
    String position;

    BootstrapModalContainer(this.dialogInstance) {
        this.dialogInstance = dialogInstance;

        if (!dialogInstance.inElement) {
            this.position = null;
        } else {
            this.position = 'absolute';
        }
    }

    void onContainerClick($event) {
        $event.stopPropagation();
    }

    void onClick() {
        if (!this.dialogInstance.config.isBlocking){
            this.dialogInstance.dismiss();
        }
    }

   void  documentKeypress(KeyboardEvent event) {
        if ( this.dialogInstance.config.keyboard != null &&
            this.dialogInstance.config.keyboard.indexOf(event.keyCode) > -1) {
            this.dialogInstance.dismiss();
        }
    }
}