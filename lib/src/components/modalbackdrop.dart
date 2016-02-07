part of ng2_dart_modal;

/**
 * Represents the modal backdrop.
 */
@Component(
    selector: 'modal-backdrop',
    host: const {
        '[style.position]': 'position',
        '[style.height]': 'height',
        '[style.width]': 'width',
        '[style.top]': 'top',
        '[style.left]': 'left',
        '[style.right]': 'right',
        '[style.bottom]': 'bottom'
    },
    template: '''
		<div [style.position]="position" class="in modal-backdrop" #modalBackdrop></div>
		'''
)

class ModalBackdrop {
    String position;
    String height;
    String width;
    String top;
    String left;
    String right;
    String bottom;

    ModalBackdrop(ModalDialogInstance dialog) {
        if (!dialog.inElement) {
            this.position = this.width = this.height = null;
            this.top = this.left = this.right = this.bottom = null;
        } else {
            this.position = 'absolute';
            this.height = '100%';
            this.width = '100%';
            this.top = this.left = this.right = this.bottom = '0';
        }
    }
}