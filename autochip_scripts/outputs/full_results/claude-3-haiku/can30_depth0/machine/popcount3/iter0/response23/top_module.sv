module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Add the three input bits together
    wire [2:0] sum = in[0] + in[1] + in[2];

    // Assign the output bits
    assign out[0] = sum[0];
    assign out[1] = sum[1];

endmodule
