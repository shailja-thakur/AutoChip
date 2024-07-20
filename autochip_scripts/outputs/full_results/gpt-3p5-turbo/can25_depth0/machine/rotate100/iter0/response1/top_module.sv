module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always@(posedge clk) begin
		if (load)
			q <= data;
		else begin
			if (ena == 2'b01) // shift to the left
				q <= {q[98:0], 1'b0};
			else if (ena == 2'b10) // shift to the right
				q <= {1'b0, q[99:1]};
			else
				q <= q; // no shift
		end
	end

endmodule
