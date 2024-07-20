module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] temp;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			temp <= q;
			if (ena == 2'b01) begin
				q <= {temp[98:0], 1'b0};
			end else if (ena == 2'b10) begin
				q <= {1'b0, temp[99:1]};
			end else begin
				q <= temp;
			end
		end
	end

endmodule
