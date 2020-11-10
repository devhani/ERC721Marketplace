pragma solidity ^0.6.0;
import "openzeppelin-solidity/contracts/access/RBAC.sol";



contract CompanyRegistry {
    
    address bookkeepingtoken;
    address platform;
    address fees;
    address orderbookproxy;
    address expensebookproxy;
    address access_address;
    
    PermissionControl access;

    constructor(address _access,address _b, address _p, address _f) public 
    {
        access = PermissionControl(_access);
        require(_isAdmin(msg.sender),"CR01");
        bookkeepingtoken=_b;
        platform = _p;
        fees = _f;
    }
    
   function setbookkeepingtoken(address _a) public {
        require(_isAdmin(msg.sender),"CR02");
        bookkeepingtoken=_a;
        
        bytes memory payload = abi.encodeWithSignature("setbookkeep(address)",_a);
        (bool success,) = orderbookproxy.call(payload);
        require(success,"O23");
    }
    
    function setplatform(address _a) public {
        require(_isAdmin(msg.sender),"CR02");
        platform=_a;
        
        bytes memory payload = abi.encodeWithSignature("setplatform(address)",_a);
        (bool success,) = orderbookproxy.call(payload);
        require(success,"O23");
        
    }
    
    function setfees(address _a) public {
        require(_isAdmin(msg.sender),"CR02");
        fees=_a;
        
        bytes memory payload = abi.encodeWithSignature("setplatformfees(address)",_a);
        (bool success,) = orderbookproxy.call(payload);
        require(success,"O23");
    }
    
    function setOrderbookproxy(address _a) public {
        require(_isAdmin(msg.sender),"CR02");
        orderbookproxy=_a;
    }
    
    function setExpensebookProxy(address _a) public {
        require(_isAdmin(msg.sender),"CR02");
        expensebookproxy=_a;
        
        bytes memory payload = abi.encodeWithSignature("setexpenseProxy(address)",_a);
        (bool success,) = orderbookproxy.call(payload);
        require(success,"O23");
    }
    
    function setAccess(address _a) public {
        require(_isAdmin(msg.sender),"CR02");
        access = PermissionControl(_a);
        
        bytes memory payload = abi.encodeWithSignature("setPermissionControl(address)",_a);
        (bool success,) = orderbookproxy.call(payload);
        require(success,"O23");
    }
    
    function _isAdmin(address _a) internal view
    returns(bool _t)
    {
        return access.hasRole(access.ADMIN_ROLE(),_a);
    }
    
    
 
    
    

    
    
    
}