module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] reg32;

	always @(posedge clk or posedge reset) begin
		if (reset)
			reg32 <= 32'h1;
		else
			reg32 <= {reg32[31] ^ reg32[21] ^ reg32[1] ^ reg32[0], reg32[31:1]};
	end
	
	assign q = reg32;
	
endmodule
