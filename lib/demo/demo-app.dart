part of ng2_dart_modal_demo;

/*
 * App Component
 * Top Level Component
 */
@Component(
    selector: 'demo-app', // <app></app>
    // We need to tell Angular's Dependency Injection which providers are in our app.
    providers: const [FORM_PROVIDERS],
    // We need to tell Angular's compiler which directives are in our template.
    // Doing so will allow Angular to attach our behavior to an element
    directives: const [ROUTER_DIRECTIVES],
    // We need to tell Angular's compiler which custom pipes are in our template.
    pipes: const [],
    // Our list of styles in our component. We may add more to compose many styles together
    styles: const [],
    // Every Angular template is first compiled by the browser before Angular runs it's compiler
    template: '''
        <main>
            <router-outlet></router-outlet>
        </main>
    '''
)

@RouteConfig(const [
    const Route(path: '/',        component: DemoPage,      name: 'Demo'),
])

class DemoApp {

    ElementRef elementRef;

    DemoApp(this.elementRef);
}
