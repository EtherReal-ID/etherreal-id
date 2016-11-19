

export class App {
    constructor() {
        this.heading = 'Welcome to etherReal ID!';
        this.firstName = 'Ether';
        this.lastName = 'Real';
    }
    get fullName() {
        return `${this.firstName} ${this.lastName}`;
    }
    welcome() {
        alert(`Welcome, ${this.fullName}!`);
    }
}

new App().welcome()