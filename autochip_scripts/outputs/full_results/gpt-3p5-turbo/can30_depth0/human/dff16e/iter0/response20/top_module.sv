module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] q_lower;
	reg [7:0] q_upper;

	always @(posedge clk) begin
		if (!resetn)
			q <= 16'b0;
		else begin
			if (byteena[0])
				q_lower <= d[7:0];
			if (byteena[1])
				q_upper <= d[15:8];
		end
	end

	always @(posedge clk) begin
		q[7:0] <= q_lower;
		q[15:8] <= q_upper;
	end

endmodule
