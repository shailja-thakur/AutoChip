module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire signed [8:0] sum; // Extend the sum to 9 bits to detect overflow

    assign sum = {a[7], a} + {b[7], b}; // Extend the inputs to signed 9 bits and add
    assign s = sum[7:0]; // Assign the lower 8 bits to the output
    assign overflow = (sum[8] != sum[7]); // Check if carry out of the MSB

endmodule
