module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Calculate the sum of the three input bits
    wire [3:0] sum = in[0] + in[1] + in[2];

    // Assign the two least significant bits of the sum to the output
    assign out[0] = sum[0];
    assign out[1] = sum[1];

endmodule
