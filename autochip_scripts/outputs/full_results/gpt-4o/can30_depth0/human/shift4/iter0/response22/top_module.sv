module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 4'b0000;  // Reset q to 0
		end else if (load) begin
			q <= data;    // Load data into q
		end else if (ena) begin
			q[3:1] <= q[2:0];  // Shift right
			q[0] <= 1'b0;      // q[0] becomes 0
		end
	end

endmodule
