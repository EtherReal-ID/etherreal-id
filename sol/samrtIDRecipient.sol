contract smartIDRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); }


contract Ethereal_Smart_ID {

    Ethereal_Smart_ID remote;
    address validating;
    address public smartIDowner;

    Pretorian pretorian;
    address pa;
    address waitingWallet;

    address[] public validators;
    uint[] public validatorsWhat;
    address[] public validated;
    uint[] public validatedWhat;
    address[] public wallets;
    address[] public family;
    uint public lastImageUpdate;  //block number
    uint public lastCheck;  //block number

    string public standard = 'EtherRe.al 0.1';
    string public name;
    string public id;
    string public passport;
    string public email;
    uint public birthday;
    string public physicaladdress;
    string public location;
    uint public blackflags;
    uint rating; //depends on action

    bool public checkemail;
    bool public checkaddress;
    bool public checkimage;
    uint public checkimageamount;

    mapping (address => uint256) public balanceOf;
    mapping (address => uint256) public allowance;
    uint[] public allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function Ethereal_Smart_ID(address validator,string name,string id,string passport){
      validators.push(validator);
      pretorian=Pretorian(msg.sender);
      pa=msg.sender;
      blackflags=0;
      rating=999999990; //negative number = -10
    }

    function Validate(string name,string id,string passport){
      if(msg.sender!=smartIDowner)throw;
      if(!pretorian.registerSmartID(name,id,passport))throw;
    }

    function addValidated(address a){
      if(msg.sender!=pa)throw;
      validated.push(a);
    }

    function addFamily(address a){
      if(msg.sender!=smartIDowner)throw;
      family.push(a);
    }

    function removeFamily(address a){
      if(msg.sender!=smartIDowner)throw;
      for(uint i=0;i<family.length;i++){
         if(family[i]==a)
         family[i]=family[family.length-1];
         family[family.length-1]=0x0;
      }
    }

    function addWallet(address a){
      if((msg.sender!=smartIDowner)||(msg.sender!=waitingWallet)||(wallets.length>50))throw;
      if(msg.sender==smartIDowner){
          waitingWallet=a;
      }
      if(msg.sender==waitingWallet){
         if(!pretorian.registerWallet(waitingWallet,smartIDowner))throw;
         wallets.push(waitingWallet); 
      }
    }

    function removeWallet(address a){
      if(msg.sender!=smartIDowner)throw;
      if(!pretorian.deleteWallet(a,smartIDowner))throw;
      for(uint i=0;i<wallets.length;i++){
         if(wallets[i]==a)
         wallets[i]=wallets[wallets.length-1];
         wallets[wallets.length-1]=0x0;
      }
    }

    function verifyAddress(address a,string addr){
      if(msg.sender!=smartIDowner)throw;
      remote=Ethereal_Smart_ID(a);
      if(!remote.addressVerified(addr))throw;
      validated.push(a);
      validatedWhat.push(0);
    }

    function addressVerified(string addr) returns (bool){
      if(!pretorian.isSmartID(msg.sender))throw;
      checkaddress=true;
      validators.push(msg.sender);
      validatorsWhat.push(0);
      return true;
    }

    function verifyEmail(address a,string addr){
      if(msg.sender!=smartIDowner)throw;
      remote=Ethereal_Smart_ID(a);
      if(!remote.emailVerified())throw;
      validated.push(a);
      validatedWhat.push(1);
    }

    function emailVerified() returns (bool){
      if(!pretorian.isSmartID(msg.sender))throw;
      checkemail=true;
      validators.push(msg.sender);
      validatorsWhat.push(1);
            return true;
    }

    function verifyImage(address a,string addr){
      if(msg.sender!=smartIDowner)throw;
      remote=Ethereal_Smart_ID(a);
      if(!remote.imageVerified())throw;
      validated.push(a);
      validatedWhat.push(2);
    }

    function imageVerified() returns (bool){
      if(!pretorian.isSmartID(msg.sender))throw;
      checkimage=true;
      checkimageamount++;
      validators.push(msg.sender);
      validatorsWhat.push(2);
      return true;
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

    function getInfo() constant returns(address,string,uint,string,uint,uint){
      return(smartIDowner,name,birthday,location,rating-((block.number-lastCheck)/60000),blackflags);
    }

    function check() constant returns(bool,bool,bool,uint,uint,uint){
      return(checkemail,checkaddress,checkimage,checkimageamount,lastImageUpdate,lastCheck);
    }


    /* Send coins */
    function transfer(address _to, uint256 _value) {
        if(msg.sender!=smartIDowner)throw;
        if (balanceOf[smartIDowner] < _value) throw;           // Check if the smartIDowner has enough
        if(!(_to.send(_value)))throw;
        balanceOf[smartIDowner] -= _value;                     // Subtract from the smartIDowner
        Transfer(smartIDowner, _to, _value);                   // Notify anyone listening that this transfer took place
    }

    /* Allow another contract to spend some tokens in your behalf */
    function approve(address _spender, uint256 _value)
        returns (bool success) {
        if(msg.sender!=smartIDowner)throw;
        allowance[_spender] += _value;
        allowances.push(_value);
        return true;
    }

    /* Approve and then comunicate the approved contract in a single tx */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        returns (bool success) {
        if(msg.sender!=smartIDowner)throw;
        smartIDRecipient spender = smartIDRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(smartIDowner, _value, this, _extraData);
            return true;
        }
    }        

    /* A contract attempts to get the coins */
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balanceOf[smartIDowner] < _value) throw;                 // Check if the smartIDowner has enough
        if (_value > allowance[msg.sender]) throw;                   // Check allowance
        balanceOf[smartIDowner] -= _value;                           // Subtract from the smartIDowner
        if(!(_to.send(_value)))throw;
        allowance[msg.sender] -= _value;
        Transfer(smartIDowner, _to, _value);
        return true;
    }


    /* This unnamed function is called whenever someone tries to send ether to it */
    function () payable{
        balanceOf[smartIDowner]+=msg.value;
        Transfer(msg.sender, smartIDowner, msg.value);
    }
}
