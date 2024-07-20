module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [15:0] q_reg;
	reg [15:0] q_next;

	always @(posedge clk) begin
		if (!resetn)
			q_reg <= 16'b0;
		else 
			q_reg <= q_next;
	end
	
	always @* begin
		q_next = q_reg;
		if (byteena[0] && byteena[1]) 
			q_next = d;
		else if (byteena[0]) 
			q_next[7:0] = d[7:0];
		else if (byteena[1]) 
			q_next[15:8] = d[15:8];
	end
	
	assign q = q_reg;
	
endmodule
