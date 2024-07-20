module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Add the three input bits together
    wire [2:0] sum = in[0] + in[1] + in[2];

    // Assign the most significant bit to out[1] and the least significant bit to out[0]
    assign out[1] = sum[2];
    assign out[0] = sum[1:0];

endmodule
