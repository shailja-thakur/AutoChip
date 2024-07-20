module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
	
	reg [7:0] q_lower;
	reg [7:0] q_upper;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			q_lower <= 8'b0;
			q_upper <= 8'b0;
		end else if (byteena[0]) begin
			q_lower <= d[7:0];
		end else if (byteena[1]) begin
			q_upper <= d[15:8];
		end
	end
	
	always @(posedge clk) begin
		if (byteena[0] && byteena[1])
			q <= {q_upper, q_lower};
		else if (byteena[0])
			q <= {q_upper, d[7:0]};
		else if (byteena[1])
			q <= {d[15:8], q_lower};
	end
	
endmodule
