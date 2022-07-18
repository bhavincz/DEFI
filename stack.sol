//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract stackFund
{

    address owner;
 
    mapping(address => uint) userStackedFund;
    mapping(address => uint) public adminFund;
    uint public totalSupply;
    IERC20 public stackingToken;
   
    event fundStacked(uint amount,address userAddress);

    constructor(address _stakingToken)
    {
        // token = _token;
        stackingToken = IERC20(_stakingToken);
        owner = msg.sender;
    }

    function stack(uint amount) public  
    {
        require(msg.sender == owner,"Required Owner");
        // stackingToken.approve(address(this),amount);
        // stackingToken.allowance(msg.sender,address(this));
        stackingToken.transferFrom(msg.sender, address(this),amount);
        userStackedFund[msg.sender] += amount;
        adminFund[msg.sender] += amount;
        totalSupply += amount;
        emit fundStacked(amount, msg.sender );
    }

    function getAdminFund() external returns(uint)
    {
        return address(this).balance;
    }
     
}


