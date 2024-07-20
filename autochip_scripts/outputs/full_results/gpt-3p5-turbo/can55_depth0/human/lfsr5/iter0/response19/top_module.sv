module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] lfsr;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr <= 5'b1;
		else
			lfsr <= {lfsr[2]^lfsr[0], lfsr[4:1]};
	end
	
	assign q = lfsr;
	
endmodule
