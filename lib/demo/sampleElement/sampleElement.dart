part of ng2_dart_modal_demo;

@Component(
    selector: 'sample-element',
    template: '''
        <div>
            <h1>I Am an Element!</h1>
            <p>I can be modaled!</p>
         </div>
         <div #myModal></div>
    '''
)

class SampleElement {

//    @Inject(forwardRef(() => DemoPage))
    DemoPage demoPage;
    ElementRef elementRef;

    SampleElement(this.demoPage, this.elementRef) {
        //TODO: Replace with querying instead of letting the DI decide?
        demoPage.mySampleElement = elementRef;
    }
}
