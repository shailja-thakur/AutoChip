module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] temp_q;

	always @(posedge clk) begin
		if (load)
			temp_q <= data;
		else begin
			if (ena == 2'b01)
				temp_q <= {temp_q[98:0], 1'b0};
			else if (ena == 2'b10)
				temp_q <= {1'b0, temp_q[99:1]};
		end
	end

	always @(posedge clk) begin
		q <= temp_q;
	end

endmodule
