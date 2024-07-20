module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

    wire [8:0] sum; // Extra bit to capture overflow in addition.

    // Perform addition and assign to sum
    assign sum = {1'b0, a} + {1'b0, b};

    // Assign the 8-bit output s to the least significant 8 bits of sum
    assign s = sum[7:0];

    // Check for overflow: occurs if the carry in and carry out of the sign bit differ
    assign overflow = (a[7] & b[7] & ~sum[8]) | (~a[7] & ~b[7] & sum[8]);

endmodule
