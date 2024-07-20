module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Register flip flops
	reg [4:0] q_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q_reg <= 1;
		else 
			q_reg <= {q_reg[3]^q_reg[4], q_reg[0:3]};
	end
	
	assign q = q_reg;
	
endmodule
