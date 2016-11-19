System.register("app", [], function(exports_1, context_1) {
    "use strict";
    var __moduleName = context_1 && context_1.id;
    var App;
    return {
        setters:[],
        execute: function() {
            App = (function () {
                function App() {
                    this.heading = 'Welcome to the Aurelia Navigation App!';
                    this.firstName = 'John';
                    this.lastName = 'Doe';
                }
                Object.defineProperty(App.prototype, "fullName", {
                    get: function () {
                        return this.firstName + " " + this.lastName;
                    },
                    enumerable: true,
                    configurable: true
                });
                App.prototype.welcome = function () {
                    alert("Welcome, " + this.fullName + "!");
                };
                return App;
            }());
            exports_1("App", App);
            new App().welcome();
        }
    }
});
