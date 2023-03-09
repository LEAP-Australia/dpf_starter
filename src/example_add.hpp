#include <functional>
#include <iostream>

#include <dpf_api.h>

#define WINDOWS

#define CLAYER_DLLEXPORT __declspec(dllexport)

namespace leapaustralia {

struct staticData {
    static std::unique_ptr<ansys::dpf::LibraryHandle> _libraryHandle;
};

extern "C" CLAYER_DLLEXPORT int
LoadOperators(ansys::dpf::AbstractCore *core_ptr);

struct ExampleAdderOperator {
    // identify the operator
    static std::string name() { return "adder"; }

    // describe the operator
    static ansys::dpf::OperatorSpecification specification() {
        ansys::dpf::OperatorSpecification spec;

        spec.setDocumentation("Example to add the values.");

        spec.setInputPins({
            ansys::dpf::PinDefinition(0)
                .setName("vector")
                .setAcceptedTypes({ansys::dpf::types::intVector})
                .setDoc("A vector of integers to sum"),
        });

        spec.setOutputPins({
            ansys::dpf::PinDefinition(0) // set the output pin number
                .setName("sum")
                .setAcceptedTypes({ansys::dpf::types::integer})
                .setDoc("Sum of integers"),
        });

        // set the exposed properties of the operator, allowing documentation
        // generation
        spec.setProperty(ansys::dpf::spec::exposure::sExposure,
                         ansys::dpf::spec::exposure::sPublic);
        spec.setProperty(ansys::dpf::spec::category::sCategory, "custom");
        spec.setProperty(ansys::dpf::spec::sUserName, "example integer sum");

        return spec;
    }

    // define the data computation
    static void run(ansys::dpf::OperatorMain &main);
};

} // namespace leapaustralia
