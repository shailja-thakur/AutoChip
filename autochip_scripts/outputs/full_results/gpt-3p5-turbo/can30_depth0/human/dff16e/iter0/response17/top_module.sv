module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
	
	reg [7:0] q0;
	reg [7:0] q1;
	reg [7:0] q2;
	reg [7:0] q3;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			q <= 16'b0;
		else begin
			if (byteena[0])
				q0 <= d[7:0];
			if (byteena[1])
				q1 <= d[15:8];
			q2 <= q0;
			q3 <= q1;
			q = {q3, q2};
		end
	end
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			q0 <= 8'b0;
		else if (byteena[0])
			q0 <= d[7:0];
	end
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			q1 <= 8'b0;
		else if (byteena[1])
			q1 <= d[15:8];
	end
	
endmodule
