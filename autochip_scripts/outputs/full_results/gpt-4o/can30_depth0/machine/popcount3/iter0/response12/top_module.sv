module top_module (
	input [2:0] in,
	output [1:0] out
);

    // The sum of the three input bits
    wire [2:0] sum;

    // Compute the sum
    assign sum = in[2] + in[1] + in[0];
    
    // Assign the most significant and least significant bits of the sum to out
    assign out = sum[1:0];

endmodule
