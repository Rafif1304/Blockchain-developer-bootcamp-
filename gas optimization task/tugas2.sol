// Tugas 2
pragma solidity 0.8.19;

contract Counter {
    uint256 private count;

    function increment() public {
        count += 1;
    }

    function decrement() public {
        require(count > 0, "Counter: cannot decrement below 0");
        count -= 1;
    }

    function reset() public {
        count = 0;
    }

    function getCount() public view returns (uint256) {
        return count;
    }
}

contract assemblyOfCounter {
    uint private count;

    function increment() external {
        assembly {
            let currentCount := sload(0)
            let newCount := add(currentCount,1)
            sstore(0,newCount)
        }
    }
    function decrement() external {
        assembly {
           let errormessage1 := "Counter:"
           let errormessage2 := "cannot decrement below 0"
           if iszero(gt(sload(count.slot),0)) {
            let size := add(mload(errormessage1),mload(errormessage2))
            revert(and(errormessage1,errormessage2),size)
           }
        }
    }
    function reset() external {
        assembly {
        sstore(count.slot,0)
    }
    }
    function getStatus () external returns(int result) {
        assembly {
         result := sload(count.slot)
    }
    }

}