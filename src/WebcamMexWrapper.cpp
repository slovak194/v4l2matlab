#include <vector>
#include <cinttypes>

#include "mex.h"
#include <webcam.h>

#include <mexplus.h>

using namespace std;
using namespace mexplus;

template class mexplus::Session<Webcam>;

// Defines MEX API for new.
MEX_DEFINE(new) (int nlhs, mxArray* plhs[],
                 int nrhs, const mxArray* prhs[]) {
    InputArguments input(nrhs, prhs, 3);
    OutputArguments output(nlhs, plhs, 1);
    output.set(0, Session<Webcam>::create(new Webcam(input.get<string>(0), input.get<int>(1), input.get<int>(2))));
}

// Defines MEX API for delete.
MEX_DEFINE(delete) (int nlhs, mxArray* plhs[],
                    int nrhs, const mxArray* prhs[]) {
    InputArguments input(nrhs, prhs, 1);
    OutputArguments output(nlhs, plhs, 0);
    Session<Webcam>::destroy(input.get(0));
}

MEX_DEFINE(frame) (int nlhs, mxArray* plhs[],
                             int nrhs, const mxArray* prhs[]) {
    InputArguments input(nrhs, prhs, 1);
    OutputArguments output(nlhs, plhs, 1);

    Webcam* webcam = Session<Webcam>::get(input.get(0));
    auto frm = webcam->frame();

    MxArray numeric(MxArray::Numeric<std::uint8_t>(std::vector<std::size_t>{frm.height, frm.width, 3}));

    vector<mwIndex> idx = {0, 0, 0};

    for (auto h = 0; h < frm.height; h++){
        for (auto w = 0; w < frm.width; w++){
            for (auto c = 0; c < 3; c++){
                idx[0] = static_cast<unsigned long>(h);
                idx[1] = static_cast<unsigned long>(w);
                idx[2] = static_cast<unsigned long>(c);
                auto raw_idx = h*frm.width*3 + w*3 + c;

                numeric.set(idx, *(frm.data + raw_idx));
            }
        }
    }

    MxArray struct_array(MxArray::Struct());
    struct_array.set("width", frm.width);
    struct_array.set("height", frm.height);
    struct_array.set("size", frm.size);
    struct_array.set("data", numeric.release());
    plhs[0] = struct_array.release();

}

MEX_DISPATCH // Don't forget to add this if MEX_DEFINE() is used.


