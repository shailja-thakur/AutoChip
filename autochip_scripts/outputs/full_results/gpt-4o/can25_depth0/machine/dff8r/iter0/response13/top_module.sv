module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 8'b0; // Reset q to 0
		end else begin
			q <= d;    // Store the value of d in q
		end
	end

endmodule
