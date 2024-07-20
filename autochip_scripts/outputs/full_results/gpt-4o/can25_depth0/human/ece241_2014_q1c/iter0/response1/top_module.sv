module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] extended_sum;

    // Perform the addition
    assign extended_sum = {a[7], a} + {b[7], b};
    assign s = extended_sum[7:0];

    // Check for overflow
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
