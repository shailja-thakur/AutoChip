module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] q_0_7;
	reg [7:0] q_8_15;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			q_0_7 <= 8'b0;
			q_8_15 <= 8'b0;
		end else begin
			if (byteena[0])
				q_0_7 <= d[7:0];
			if (byteena[1])
				q_8_15 <= d[15:8];
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			q <= 16'b0;
		else
			q <= {q_8_15, q_0_7};
	end

endmodule
