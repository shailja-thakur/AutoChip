module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [15:0] q_temp;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			q_temp <= 16'b0;
		end else if (byteena[0] && byteena[1]) begin
			q_temp <= d;
		end else if (byteena[0]) begin
			q_temp[7:0] <= d[7:0];
		end else if (byteena[1]) begin
			q_temp[15:8] <= d[15:8];
		end
	end

	always @(posedge clk) begin
		if (resetn)
			q <= q_temp;
	end

endmodule
