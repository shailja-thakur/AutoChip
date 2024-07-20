module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Adding the three input bits to get the output bits
    assign out[1] = in[2] + in[1] + in[0];
    assign out[0] = in[1] + in[0];

endmodule
