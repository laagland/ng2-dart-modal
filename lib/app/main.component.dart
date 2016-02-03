part of start;

@Component(
    selector: 'app',
    template: '''
    <div>Hello World!</div>
    <router-outlet></router-outlet>
    ''',
    directives: const [ROUTER_DIRECTIVES]
)

@RouteConfig(const [
    const Route(path: '/',        component: HomeComponent,      name: 'Home',   useAsDefault: true)
])

class MainComponent {
    String name = "Ng2 Dart Start";
}