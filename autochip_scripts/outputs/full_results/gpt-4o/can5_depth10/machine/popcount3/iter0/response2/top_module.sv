module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Perform the addition of the three input bits
    wire [3:0] sum;
    assign sum = in[0] + in[1] + in[2];

    // Assign the result to the output bits
    assign out = sum[1:0];

endmodule
