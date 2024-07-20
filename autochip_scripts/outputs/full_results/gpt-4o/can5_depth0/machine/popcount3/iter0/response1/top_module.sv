module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Intermediate variable to store the sum
    wire [3:0] sum; 

    // Add the three input bits
    assign sum = in[0] + in[1] + in[2];

    // Assign the two least significant bits of the sum to the output
    assign out = sum[1:0];

endmodule
