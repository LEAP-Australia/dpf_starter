# DPF Starter

DPF Starter is a simple, minimal example that helps build a custom Ansys DPF operator. It serves as a starter project for new DPF operators. This repository provides a convenient way for users to get started with building their own DPF operators.

## Requirements

To build and use this project, you must have the following software installed on your system:

- CMake (tested on version 3.23.1)
- Compiler 
- Ansys Mechanical (tested on Release 2023R1)
- Conan version 1.59.0 ( cmake not configured for version 2)

## Build Steps

Follow these steps to build the project:

1. Clone this repository to your local machine.
2. Use CMake to configure and build the project.

## Test the Operator

To test the operator, use the following Python code:

```python
import mech_dpf
import Ans.DataProcessing as dpf
mech_dpf.setExtAPI(ExtAPI)

dpf.DataProcessingCore.LoadLibrary("leapaustralia", r"path\to\dpf.starter.dll", "LoadOperators")

op = dpf.Operator("adder")
op.Connect(0, (1,2,3))
op.GetOutputAsInt(0)
```

## License

This is free and unencumbered software released into the public domain. Please see the [LICENSE](LICENSE) file for more details.

## Contributing

If you'd like to contribute to this project, please follow the [contribution guidelines](CONTRIBUTING.md).

## Contact

If you have any questions or feedback, please feel free to contact us via the [issue tracker](https://github.com/LEAP-Australia/dpf_starter/issues).
