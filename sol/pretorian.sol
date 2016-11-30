//  
//    First draft.  
//    This is not a deployment contract
//    strictly alfa!!!
//


contract Pretorian {

    Ethereal_Smart_ID root;
    address public rootOwner;
    address public rootAddress;

    mapping(address => bool) public isSmartID; 
    mapping(address => string) public smartIDnames;
    mapping(address => string) public smartIDid;
    mapping(string => bool) public smartIDidCheck;
    mapping(address => string) public smartIDpassport;
    mapping(string => bool) public smartIDpassportCheck;
    mapping(address => address[]) public smartIDwallets;
    mapping(address => bool) public registeredWallets;
    mapping(address => address) public registeredWalletsOwner;

function Pretorian(string name,string id,string passport){
   rootAddress=new Ethereal_Smart_ID(msg.sender,name,id,passport);
   isSmartID[rootAddress]=true;
   smartIDnames[rootAddress]=name;
   smartIDid[rootAddress]=sha3(id);
   smartIDidCheck[sha3(id)]=true;
   smartIDpassport[rootAddress]=sha3(passport);
   smartIDpassportCheck[sha3(passport)]=true;
   rootOwner=msg.sender;
}

function registerSmartID(string name,string id,string passport) returns (bool){
if(!isSmartID[msg.sender])throw;
if(smartIDidCheck[sha3(id)])throw;
if(smartIDpassportCheck[sha3(passport)])throw;

   address smartIDaddr=new Ethereal_Smart_ID(msg.sender,name,id,passport);
   isSmartID[smartIDaddr]=true;
   smartIDnames[smartIDaddr]=name;
   smartIDnames[smartIDaddr]=sha3(id);
   smartIDidCheck[sha3(id)]=true;
   smartIDid[smartIDaddr]=sha3(passport)
   smartIDpassportCheck[sha3(passport)]=true;

}

function registerWallet(address a,address owner)returns(bool){
   if(!isSmartID[msg.sender])throw;
   if(registeredWallets[a])throw;
   smartIDwallets[msg.sender].push(a);
   registeredWallets[a]=true;
   registeredWalletsOwner[a]=owner;
}

function deleteWallet(address a,address owner)returns(bool){
   if(!isSmartID[msg.sender])throw;
   if(!registeredWallets[a])throw;
   if(registeredWalletsOwner[a]!=owner)throw;

for(uint i=0;i<smartIDwallets[msg.sender].length;i++){
    if(smartIDwallets[msg.sender][i]==a)
       smartIDwallets[msg.sender][i]=smartIDwallets[msg.sender][smartIDwallets[msg.sender].length-1];
    smartIDwallets[msg.sender][smartIDwallets[msg.sender].length-1]=0x0;
    registeredWallets[a]=false;
    }
}

function WHOIS(address a)constant returns(bool,string,string,string){
   return(isSmartID[a],smartIDnames[a],smartIDid[a],smartIDpassport[a]);
}


}

