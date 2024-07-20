module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] q0, q1;

	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			q <= 16'b0;
		else begin
			if (byteena[0])
				q0 <= d[7:0];
			if (byteena[1])
				q1 <= d[15:8];
			q[7:0] <= q0;
			q[15:8] <= q1;
		end
	end

endmodule
