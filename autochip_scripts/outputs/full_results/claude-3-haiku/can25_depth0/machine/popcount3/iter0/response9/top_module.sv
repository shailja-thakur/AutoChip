module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Calculate the sum of the three input bits
    wire [3:0] sum;
    assign sum = in[0] + in[1] + in[2];

    // Store the most significant bit and the least significant bit of the sum in the output bits
    assign out[1] = sum[3];
    assign out[0] = sum[2];

endmodule
