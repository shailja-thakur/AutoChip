module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire areset,
	output reg [7:0] q);

	reg [7:0] q_next;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			q_next <= 8'b00000000;
		else
			q_next <= d;
	end
	
	always @(posedge clk)
	begin
		q <= q_next;
	end
	
endmodule
