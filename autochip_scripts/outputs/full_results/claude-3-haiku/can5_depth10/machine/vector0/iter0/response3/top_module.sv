module top_module(
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);

    // Assign the output vector 'outv' to be the same as the input vector 'vec'
    assign outv = vec;

    // Assign the individual output bits 'o2', 'o1', and 'o0' to be the corresponding bits of the input vector 'vec'
    assign o2 = vec[2];
    assign o1 = vec[1];
    assign o0 = vec[0];

endmodule
