// Tugas 3
pragma solidity ^0.8.19;

contract BatchProcessor {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public distributed;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function batchProcess(address[] memory recipients, uint[] memory amounts) public {
        require(recipients.length == amounts.length, "Arrays must be of equal length");

        for (uint i = 0; i < recipients.length; i++) {
            require(balances[msg.sender] >= amounts[i], "Insufficient balance");
            balances[msg.sender] -= amounts[i];
            balances[recipients[i]] += amounts[i];
            distributed[msg.sender][recipients[i]] = amounts[i];
        }
    }
}
//optimized version
// Tugas 3
contract OptimizeBatchProcessor {
    mapping(address => uint) public balances;
   
    struct Transfer{
        address recipient;
        uint amount;
    }
    event distributed(address sender, address to );
    error Insufficientbalance();

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function batchProcess(Transfer[] calldata transfer) external {
        uint length = transfer.length;

        for (uint i = 0; i < length; i++) {
            if(balances[msg.sender] >= transfer[i].amount)
            revert Insufficientbalance();

            balances[msg.sender] -= transfer[i].amount;
            balances[transfer[i].recipient] += transfer[i].amount;
            emit distributed(
                msg.sender,
                transfer[i].recipient);
        }
    }
}
