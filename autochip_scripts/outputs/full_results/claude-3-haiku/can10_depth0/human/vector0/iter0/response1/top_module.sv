module top_module(
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);

    // Connect the input vector to the output vector
    assign outv = vec;

    // Split the input vector into individual outputs
    assign o2 = vec[2];
    assign o1 = vec[1];
    assign o0 = vec[0];

endmodule
