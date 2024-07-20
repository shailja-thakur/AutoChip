module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Perform population count on the 3-bit input vector
    assign out = in[0] + in[1] + in[2];

endmodule
