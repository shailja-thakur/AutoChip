module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			ena <= 3'b000;
		end else if (ena[1]) begin
			q <= q + 16'b0001;
			ena <= ena;
		end else if (ena[2]) begin
			q <= q + 16'b0010;
			ena <= ena;
		end else if (ena[3]) begin
			q <= q + 16'b0100;
			ena <= ena;
		end
	end
endmodule
