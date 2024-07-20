module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
	
	reg [7:0] upper_byte;
	reg [7:0] lower_byte;
	
	always @(posedge clk) begin
		if (resetn == 0) begin
			upper_byte <= 8'b0;
			lower_byte <= 8'b0;
		end else begin
			if (byteena[1] == 1)
				upper_byte <= d[15:8];
			if (byteena[0] == 1)
				lower_byte <= d[7:0];
		end
	end
	
	always @(posedge clk) begin
		if (resetn == 0)
			q <= 16'b0;
		else begin
			q[15:8] <= upper_byte;
			q[7:0] <= lower_byte;
		end
	end
	
endmodule
