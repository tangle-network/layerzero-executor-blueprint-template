// SPDX-License-Identifier: UNLICENSE
pragma solidity >=0.8.13;

import "@layerzerolabs/lz-evm-messagelib-v2/contracts/interfaces/ILayerZeroExecutor.sol";

contract LayerZeroDVNInstance is ILayerZeroExecutor {
    function assignJob(uint32 _dstEid, address _sender, uint256 _calldataSize, bytes calldata _options)
        external
        returns (uint256 price)
    {
        return 0;
    }

    function getFee(uint32 _dstEid, address _sender, uint256 _calldataSize, bytes calldata _options)
        external
        view
        returns (uint256 price)
    {
        return 0;
    }
}
