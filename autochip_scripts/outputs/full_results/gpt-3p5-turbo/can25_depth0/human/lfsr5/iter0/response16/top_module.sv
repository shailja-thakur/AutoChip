module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] reg;
	always @(posedge clk or posedge reset) begin
		if (reset)
			reg <= 5'b1;
		else
			reg <= {reg[3]^reg[5], reg[4:1]};
	end

	assign q = reg;
  
endmodule
