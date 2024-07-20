module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] lower_byte;
	reg [7:0] upper_byte;

	always @(posedge clk) begin
		if (resetn == 1'b0) begin
			lower_byte <= 8'b0;
			upper_byte <= 8'b0;
		end else begin
			if (byteena[0] == 1'b1)
				lower_byte <= d[7:0];
			
			if (byteena[1] == 1'b1)
				upper_byte <= d[15:8];
		end
	end

	always @(negedge resetn or posedge clk) begin
		if (resetn == 1'b0)
			q <= 16'b0;
		else begin
			q[7:0] <= lower_byte;
			q[15:8] <= upper_byte;
		end
	end

endmodule
