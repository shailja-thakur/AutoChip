module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		// Load data into q when load is high
		if (load) begin
			q <= data;
		end else begin
			// Shift q to the left when ena is 2'h1
			if (ena == 2'b01) begin
				q <= {q[98:0], 1'b0};
			end
			// Shift q to the right when ena is 2'h2
			if (ena == 2'b10) begin
				q <= {1'b0, q[99:1]};
			end
		end
	end
endmodule
