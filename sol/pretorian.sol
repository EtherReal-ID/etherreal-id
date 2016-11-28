//  
//    First draft.  
//    This is not a deployment contract
//    strictly alfa!!!
//


contract Pretorian {

   etherReal_Smart_ID root;
   address public rootOwner;
   address public rootAddress;

   mapping(address => bool) public isSmartID; 
   mapping(address => string) public smartIDnames;
   mapping(address => string) public smartIDid;
   mapping(address => string) public smartIDpassport;

function Pretorian(string name,string id,string passport){
  rootAddress=new etherReal_Smart_ID(msg.sender,name,id,passport);
  isSmartID[rootAddress]=true;
  smartIDnames[rootAddress]=name;
  smartIDnames[rootAddress]=id;
  smartIDid[rootAddress]=passport;
  rootOwner=msg.sender;
}

function registerSmartID(address smartIDadd,string name,string id,string passport) returns (bool){
if(!isSmartID[msg.sender])throw;
  address smartIDaddr=new etherReal_Smart_ID(msg.sender,name,id,passport);
  isSmartID[smartIDaddr]=true;
  smartIDnames[smartIDaddr]=name;
  smartIDnames[smartIDaddr]=id;
  smartIDid[smartIDaddr]=passport;

}

function WHOIS(address a)constant returns(bool,string,string,string){
return(isSmartID[a],smartIDnames[a],smartIDid[a],smartIDpassport[a]);
}


}


contract etherReal_Smart_ID {


   address validating;
   address public smartIDowner;

   Pretorian pretorian;
   address pa;

   address[] public validators;
   address[] public validated;
   address[] public wallets;

   string public name;
   string public id;
   string public passport;

function etherReal_Smart_ID(address validator,string name,string id,string passport){
 validators.push(validator);
 pretorian=Pretorian(msg.sender);
 pa=msg.sender;
}

function Validate(string name,string id,string passport){
if(msg.sender!=smartIDowner)throw;
if(!pretorian.registerSmartID(validating,name,id,passport))throw;
}

function addValidated(address a){
   if(msg.sender!=pa)throw;
   validated.push(a);
}

function getValidator(uint v)constant returns(address,uint){
 return (validators[v],wallets.length);
}

function getValidated(uint v)constant returns(address,uint){
 return (validated[v],wallets.length);
}

function getWallet(uint w)constant returns(address,uint){
 return (wallets[w],wallets.length);
}

function getInfo() constant returns(address,string,string,string){
return(smartIDowner,name,id,passport);
}

}
