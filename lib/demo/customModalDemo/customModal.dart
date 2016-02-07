part of ng2_dart_modal_demo;

class AdditionCalculateWindowData {
    int num1;
    int num2;

    AdditionCalculateWindowData(this.num1, this.num2);
}

/**
 * A Sample of how simple it is to create a new window, with its own injects.
 */
@Component(
    selector: 'modal-content',
    directives: const [CORE_DIRECTIVES, FORM_DIRECTIVES],
    styles: const ['.custom-modal-container {padding: 15px;}',
             '.custom-modal-header {background-color: #219161;color: #fff;-webkit-box-shadow: 0px 3px 5px 0px rgba(0,0,0,0.75);-moz-box-shadow: 0px 3px 5px 0px rgba(0,0,0,0.75);box-shadow: 0px 3px 5px 0px rgba(0,0,0,0.75);margin-top: -15px;margin-bottom: 40px;}'
            ],
    //TODO: [ngClass] here on purpose, no real use, just to show how to workaround ng2 issue #4330.
    // Remove when solved.
    /* tslint:disable */
    template: '''
        <div class="container-fluid custom-modal-container">
            <div class="row custom-modal-header">
                <div class="col-sm-12">
                    <h1>A Custom modal design</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="jumbotron">
                        <h1>Do the math to quit:</h1>
                        <p class="lead">I received an injection of the number <strong>{{context.num1}}</strong> and the number <strong>{{context.num2}}</strong></p>
                        <span>What is the sum?</span>
                         <input class="form-control" type="text" #answer (keyup)="onKeyUp(answer.value)" autofocus>
                    </div>
                </div>
            </div>
        </div>
        '''
)

class AdditionCalculateWindow implements ICustomModalComponent {
    ModalDialogInstance dialog;
    AdditionCalculateWindowData context;
    bool wrongAnswer;

    AdditionCalculateWindow(ModalDialogInstance dialog, ICustomModal modelContentData) {
        this.dialog = dialog;
        this.context = modelContentData as AdditionCalculateWindowData;
//        this.wrongAnswer = wrongAnswer;
    }

//    AdditionCalculateWindow(this.dialog, this.context, this.wrongAnswer);

    onKeyUp(value) {

        /* tslint:disable */
        this.wrongAnswer = ((value != '') && int.parse(value) == 5);
        this.dialog.close(result: this.wrongAnswer);
    }


    bool beforeDismiss() {
        return true;
    }

    bool beforeClose() {
        return !this.wrongAnswer;
    }
}
