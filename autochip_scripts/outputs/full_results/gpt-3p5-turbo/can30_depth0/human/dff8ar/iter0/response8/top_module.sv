module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire areset,
	output reg [7:0] q);
	
	reg [7:0] q_reg;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			q_reg <= 8'b0;
		else
			q_reg <= d;
	end
	
	assign q = q_reg;
endmodule
