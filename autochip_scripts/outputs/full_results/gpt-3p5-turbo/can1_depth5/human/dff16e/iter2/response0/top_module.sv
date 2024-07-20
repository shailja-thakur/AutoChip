module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [15:0] q_temp;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			q_temp <= 16'b0;
		end else begin
			q_temp <= q_temp;
			if (byteena[1]) begin
				q_temp[15:8] <= d[15:8];
			end
			if (byteena[0]) begin
				q_temp[7:0] <= d[7:0];
			end
		end
	end

	always @(posedge clk) begin
		if (resetn) begin
			q <= q_temp;
		end
	end

endmodule
