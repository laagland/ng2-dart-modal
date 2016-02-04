part of ng2_dart_modal;

/**
 * Represents the modal backdrop.
 */
@Component(
    selector: 'modal-backdrop',
    host: {
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
    public position: string;
    public height: string;
    public width: string;
    public top: string;
    public left: string;
    public right: string;
    public bottom: string;


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