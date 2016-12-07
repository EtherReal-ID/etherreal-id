System.register("app", ['aurelia-framework', 'aurelia-api'], function(exports_1, context_1) {
    "use strict";
    var __moduleName = context_1 && context_1.id;
    var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
        var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
        if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
        else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
        return c > 3 && r && Object.defineProperty(target, key, r), r;
    };
    var aurelia_framework_1, aurelia_api_1;
    var App;
    return {
        setters:[
            function (aurelia_framework_1_1) {
                aurelia_framework_1 = aurelia_framework_1_1;
            },
            function (aurelia_api_1_1) {
                aurelia_api_1 = aurelia_api_1_1;
            }],
        execute: function() {
            App = (function () {
                function App(config) {
                    this.heading = 'Welcome to etherReal ID!';
                    this.firstname = 'Ether';
                    this.lastname = 'Real';
                    this.apiEndpoint = config.getEndpoint('api');
                    //this.welcome();
                }
                Object.defineProperty(App.prototype, "fullname", {
                    get: function () {
                        return this.firstname + " " + this.middlename + " " + this.lastname;
                    },
                    enumerable: true,
                    configurable: true
                });
                App.prototype.welcome = function () {
                    var _this = this;
                    this.apiEndpoint.find('user')
                        .then(function (user) {
                        //alert(`Users = ${user[0]}`);
                        _this.users = user;
                        // use your received users.json
                    })
                        .catch(console.error);
                    alert("Welcome, " + this.fullname);
                };
                App = __decorate([
                    aurelia_framework_1.inject(aurelia_api_1.Config)
                ], App);
                return App;
            }());
            exports_1("App", App);
        }
    }
});
// export class App {
// @inject(Configure)
// constructor(config) {
//         this.heading = 'Welcome to etherReal ID!';
//         this.firstName = 'Ether';
//         this.lastName = 'Real';
//         this.config = config;
//     }
//     get fullName() {
//         return `${this.firstName} ${this.lastName}`;
//     }
//     welcome() {
//         alert(`Welcome, ${this.fullName}!`);
//     }
// }
// new App().welcome()
