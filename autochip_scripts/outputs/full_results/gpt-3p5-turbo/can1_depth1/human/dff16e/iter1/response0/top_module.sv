module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] q_lower;
	reg [7:0] q_upper;
	reg reset_clk;

	always @(posedge clk) begin
		reset_clk <= resetn;
	end

	always @(posedge clk or negedge reset_clk) begin
		if (!resetn) begin
			q_lower <= 8'd0;
			q_upper <= 8'd0;
		end else begin
			if (byteena[0])
				q_lower <= d[7:0];
			if (byteena[1])
				q_upper <= d[15:8];
		end
	end

	assign q = {q_upper, q_lower};

endmodule
