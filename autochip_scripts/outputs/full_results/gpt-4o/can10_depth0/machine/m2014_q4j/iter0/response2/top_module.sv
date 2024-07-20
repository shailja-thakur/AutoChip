module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

    // Compute the sum of x and y including the carry bit
    assign sum = x + y;

endmodule
