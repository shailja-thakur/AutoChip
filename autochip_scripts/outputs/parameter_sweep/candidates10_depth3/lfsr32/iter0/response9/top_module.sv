module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 32'h1;
			q <= 32'h1;
		end else begin
			state <= {state[31:1], (state[22] ^ state[2] ^ state[1] ^ state[0])};
			q <= state;
		end
	end
	
endmodule
