module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
	
	reg [7:0] lower_byte_d;
	reg [7:0] upper_byte_d;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			lower_byte_d <= 8'b0;
			upper_byte_d <= 8'b0;
		end else begin
			if (byteena[0])
				lower_byte_d <= d[7:0];
			if (byteena[1])
				upper_byte_d <= d[15:8];
		end
	end
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			q <= 16'b0;
		else begin
			q[7:0] <= lower_byte_d;
			q[15:8] <= upper_byte_d;
		end
	end
	
endmodule
