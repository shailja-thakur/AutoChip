module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wires
	wire [8:0] sum;

	// Full adder for LSB
	full_adder fa0 (.a(a[0]), .b(b[0]), .cin(1'b0), .sum(sum[0]), .cout(sum[1]));

	// Carry ripple adder for remaining bits
	genvar i;
	generate
		for (i = 1; i < 8; i = i + 1) begin : ripple_adder
			full_adder fa (.a(a[i]), .b(b[i]), .cin(sum[i]), .sum(sum[i]), .cout(sum[i+1]));
		end
	endgenerate

	// Wire outputs
	assign overflow = (a[7] == b[7] && sum[8] != a[7]) || (a[7] != b[7] && sum[8] == a[7]);
	assign s = sum[7:0];

endmodule
