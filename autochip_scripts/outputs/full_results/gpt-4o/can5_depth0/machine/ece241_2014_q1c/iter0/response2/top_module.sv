module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [8:0] sum; // 9-bit width to capture the overflow

    assign sum = a + b; // Perform the addition
    assign s = sum[7:0]; // Assign the lower 8 bits to s
    assign overflow = sum[8] ^ sum[7]; // Check overflow by comparing the 8th and 7th bits of sum

endmodule
