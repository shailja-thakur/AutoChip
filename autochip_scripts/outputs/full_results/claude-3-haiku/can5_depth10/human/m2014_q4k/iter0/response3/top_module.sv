module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	// Internal wire declarations
	wire Q1, Q2, Q3, Q4;

	// D flip-flop instances
	dff dff1 (.clk(clk), .reset_n(resetn), .d(in),  .q(Q1));
	dff dff2 (.clk(clk), .reset_n(resetn), .d(Q1),  .q(Q2));
	dff dff3 (.clk(clk), .reset_n(resetn), .d(Q2),  .q(Q3));
	dff dff4 (.clk(clk), .reset_n(resetn), .d(Q3),  .q(Q4));

	// Assign output
	assign out = Q4;

endmodule
module dff (
	input clk,
	input reset_n,
	input d,
	output reg q
);

	always @(posedge clk) begin
		if (~reset_n)
			q <= 1'b0;
		else
			q <= d;
	end

endmodule
