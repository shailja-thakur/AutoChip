module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset shift register to zero
			q <= 0;
		end else if (load) begin
			// Load shift register with data[3:0] instead of shifting
			q <= data;
		end else if (ena) begin
			// Shift right (q[3] becomes zero, q[0] is shifted out and disappears)
			q <= {1'b0, q[3:1]};
		end
	end
endmodule
