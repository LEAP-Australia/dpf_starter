#include <cstdlib>
#include <ctime>
#include <filesystem>

#include <spdlog/spdlog.h>
#include <spdlog/sinks/basic_file_sink.h>

#include "example_add.hpp"

#include "dpf_api_i.cpp"

namespace leapaustralia {
std::unique_ptr<ansys::dpf::LibraryHandle> staticData::_libraryHandle =
    std::unique_ptr<ansys::dpf::LibraryHandle>(new ansys::dpf::LibraryHandle());

extern "C" CLAYER_DLLEXPORT int
LoadOperators(ansys::dpf::AbstractCore *core_ptr) {
    ansys::dpf::core::recordOperatorAtCore<ExampleAdderOperator>(
        core_ptr); // record the operator to make it accessible
    return 0;
}

void ExampleAdderOperator::run(ansys::dpf::OperatorMain &main) {
    namespace fs = std::filesystem;
    fs::path loggingDir;
    if(_WIN32) {
        loggingDir = std::getenv("TEMP");
    } else {
        loggingDir = "/tmp";
    }
    const auto log_file_name = ( loggingDir / fs::path("dpf_example.log")).string();

    auto logger = spdlog::basic_logger_mt("example_dpf", log_file_name);
    logger->set_level(spdlog::level::debug);
    logger->info("Started example DPF operator");

    // get the input data
    auto listInts = main.getInputVecInt(0);

    int sum{0};

    for (const auto v : listInts) {
        sum += v;
    }
    logger->info("Result computed");

    main.setOutput(0, sum);
    main.setSuccessed();
    logger->info("Finished run!");
}

} // namespace leapaustralia
