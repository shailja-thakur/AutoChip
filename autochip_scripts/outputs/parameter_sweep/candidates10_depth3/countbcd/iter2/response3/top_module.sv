module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal signal to keep track of enable signals
	reg [3:0] en;

	always @(posedge clk) begin
		if (reset) begin
			q <= 16'b0000;
			en <= 4'b0000;
		end else begin
			if (ena[1]) begin
				q <= q + 4'b0001;
			end
			if (ena[2]) begin
				q <= q + 4'b0010;
			end
			if (ena[3]) begin
				q <= q + 4'b0100;
			end
			en <= ena;
		end
	end

	// Assign the enable signals to the output
	assign ena = en[3:1];

endmodule
