module top_module(
	input wire clk,
	input wire load,
	input wire [1:0] ena,
	input wire [99:0] data,
	output reg [99:0] q);
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			if (ena == 2'h1) begin
				q <= {q[98:0], 1'b0};
			end else if (ena == 2'h2) begin
				q <= {1'b0, q[99:1]};
			end
		end
	end
endmodule
