module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum; // Extend the sum to capture overflow

    // Perform the addition
    assign sum = {a[7], a} + {b[7], b}; 

    // Assign the lower 8 bits to s
    assign s = sum[7:0];

    // Detect overflow: Check if the sign bit differs from the extended sum's sign bit
    assign overflow = (a[7] == b[7]) && (sum[8] != a[7]);

endmodule
