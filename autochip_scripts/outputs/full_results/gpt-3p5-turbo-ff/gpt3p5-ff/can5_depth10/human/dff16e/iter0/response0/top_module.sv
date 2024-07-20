module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] d_lower;
	reg [7:0] d_upper;
	reg q_lower;
	reg q_upper;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			d_lower <= 8'd0;
			d_upper <= 8'd0;
			q_lower <= 1'b0;
			q_upper <= 1'b0;
		end
		else begin
			if (byteena[0] == 1'b1)
				d_lower <= d[7:0];
			if (byteena[1] == 1'b1)
				d_upper <= d[15:8];

			q_lower <= d_lower;
			q_upper <= d_upper;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			q <= 16'd0;
		else begin
			if (byteena[0] == 1'b1)
				q[7:0] <= q_lower;
			if (byteena[1] == 1'b1)
				q[15:8] <= q_upper;
		end
	end
endmodule
