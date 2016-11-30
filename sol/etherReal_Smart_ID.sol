// First draft.  
// This is not a deployment contract.
// Strictly alfa!!!
// Solidity ^0.4.6.


contract etherReal_Smart_ID {

  address          validating;
  address   public smartIDowner;
  Pretorian        pretorian;
  address          pa;

  address[] public validators;
  address[] public validated;
  address[] public wallets;

  string    public name;
  string    public id;
  string    public passport;

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
