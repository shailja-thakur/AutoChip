module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire areset,
	output reg [7:0] q);
	
	always @(posedge clk or posedge areset)
	begin
		if(areset)
			q <= 8'b0;
		else
			q <= d;
	end
endmodule
