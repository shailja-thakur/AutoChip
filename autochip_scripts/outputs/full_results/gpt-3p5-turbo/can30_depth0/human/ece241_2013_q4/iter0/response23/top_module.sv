module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);
	// Make sure all outputs are initialized
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end else begin
			// TODO: Add state machine logic here
		end
	end
endmodule
