# <h1 align="center">LayerZero Executor Blueprint Template 🚀</h1>

<p align="center">A comprehensive template for creating Executor Blueprints for LayerZero V2 on Tangle Network</p>

## 📚 Overview

This project provides a template for creating LayerZero Executor Blueprints on the Tangle Network. Executors are crucial components of the LayerZero protocol, responsible for committing and executing cross-chain messages, ensuring the reliability and efficiency of inter-blockchain communications.

Blueprints in Tangle are specifications for Actively Validated Services (AVS) that run arbitrary computations for a user-specified period. This template enables developers to create reusable Executor infrastructures, allowing them to participate in the LayerZero ecosystem and potentially monetize their work.

## 🛠️ Prerequisites

Before you begin, ensure you have the following software installed:

- [Rust](https://www.rust-lang.org/tools/install)
- [Forge](https://getfoundry.sh)
- [Tangle](https://github.com/tangle-network/tangle?tab=readme-ov-file#-getting-started-)

Install `cargo-tangle`, our CLI tool for creating and deploying Tangle Blueprints:

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/tangle-network/gadget/releases/download/cargo-tangle-v0.1.2/cargo-tangle-installer.sh | sh
```

Or, install from crates.io:

```bash
cargo install cargo-tangle --force
```

## 🚀 Getting Started

1. Create a new project using the Executor blueprint template:

```sh
cargo tangle blueprint create --name my-executor-blueprint --repo https://github.com/tangle-network/layerzero-executor-blueprint-template
```

2. Navigate to your project directory:

```sh
cd my-executor-blueprint
```

3. Implement your offchain Executor logic in `src/lib.rs` and onchain Executor in `contracts/src/`, building upon the provided template functions.

4. Build your project:

```sh
cargo build
```

5. Deploy your Executor blueprint to the Tangle network:

```sh
cargo tangle blueprint deploy
```

## 📖 Understanding the Template

The Executor has two main off-chain workflows:

### Committer Workflow

1. Listen for the `PacketSent` event.
2. Wait for the `ExecutorFeePaid` event to confirm assignment.
3. Listen for the `PacketVerified` event.
4. Perform an idempotency check using `ULN.verifiable()`.
5. Based on the `VerificationState`, either wait, call `commitVerification()`, or terminate.
6. Perform a final idempotency check to confirm workflow completion.

### Executor Workflow

1. Listen for the `PacketSent` event.
2. Wait for the `ExecutorFeePaid` event to confirm assignment.
3. Listen for the `PacketVerified` event.
4. Perform an idempotency check using `endpoint.executable()`.
5. Based on the `ExecutionState`, either wait, call `endpoint.lzReceive()`, or terminate.
6. Perform a final idempotency check to confirm workflow completion.

## 💼 Implementing the Executor Contract

Your Executor contract must implement the `ILayerZeroExecutor` interface:

```solidity
interface ILayerZeroExecutor {
   function assignJob(
       uint32 _dstEid,
       address _sender,
       uint256 _calldataSize,
       bytes calldata _options
   ) external payable returns (uint256 price);

   function getFee(
       uint32 _dstEid,
       address _sender,
       uint256 _calldataSize,
       bytes calldata _options
   ) external view returns (uint256 price);
}
```

- `assignJob`: Called as part of `_lzSend`.
- `getFee`: Used by applications to estimate fees before sending a packet.

## 🔍 Key Events to Monitor

- `PacketSent(bytes encodedPacket, bytes options, address sendLibrary)`
- `ExecutorFeePaid(address executor, uint256 fee)`
- `PayloadVerified(address dvn, bytes header, uint256 confirmations, bytes32 proofHash)`

## 📚 Resources

- [LayerZero V2 Documentation](https://layerzero.network/docs)
- [Tangle Network Documentation](https://docs.tangle.tools)

## 📬 Feedback and Support

If you encounter any issues or have questions, please open an issue on our [GitHub repository](https://github.com/tangle-network/layerzero-executor-blueprint-template/issues).

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for more information on how to get involved.

## 🙏 Acknowledgements

Special thanks to the LayerZero team for their support and contributions to this project.