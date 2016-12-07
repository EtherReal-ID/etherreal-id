import {Configure as configure_aur} from "aurelia-configuration";
import {inject} from 'aurelia-framework';
import {Config} from 'aurelia-api';

@inject(Config)
export class App
{
    heading: string;
    apiEndpoint: any;
    public firstname: string;
    public middlename: string;
    public lastname: string;
    public users: any;

    constructor(config: Config) {        
        this.heading = 'Welcome to etherReal ID!';
        this.firstname = 'Ether';
        this.lastname = 'Real';

        this.apiEndpoint = config.getEndpoint('api');

        
        //this.welcome();
    }

    public get fullname() : string
    {
        return `${this.firstname} ${this.middlename} ${this.lastname}`;
    }

    welcome() : void
    {
        this.apiEndpoint.find('user')
        .then(user => {
            //alert(`Users = ${user[0]}`);
            this.users = user;
        // use your received users.json
        })
        .catch(console.error);

        alert(`Welcome, ${this.fullname}`);
    }


}

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

