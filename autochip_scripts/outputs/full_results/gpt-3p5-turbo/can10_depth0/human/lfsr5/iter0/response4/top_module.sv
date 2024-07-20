module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 1;
		else
			state <= {state[3] ^ state[4], state[4:1]};
	end
	
	assign q = state;
	
endmodule
