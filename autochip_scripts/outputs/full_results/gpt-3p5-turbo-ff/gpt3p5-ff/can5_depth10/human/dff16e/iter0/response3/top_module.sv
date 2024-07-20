module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [15:0] q_tmp;

	always @(posedge clk) begin
		if (!resetn) begin
			q_tmp <= 16'b0;
		end else begin
			if (byteena[1]) begin
				q_tmp[15:8] <= d[15:8];
			end
			if (byteena[0]) begin
				q_tmp[7:0] <= d[7:0];
			end
		end
	end

	always @(posedge clk) begin
		if (!resetn) begin
			q <= 16'b0;
		end else begin
			q <= q_tmp;
		end
	end

endmodule
