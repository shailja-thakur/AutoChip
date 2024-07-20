module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal signals
	reg [8:0] temp;

	// Compute sum
	always @(a, b) begin
		temp = a + b;
		s = temp[7:0];
	end

	// Compute overflow
	assign overflow = (temp[8] == 1);

endmodule
