module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 5'b1; // Reset LFSR output to 1
		end else begin
			state <= {state[3] ^ state[0], state[4:1]}; // Update LFSR state
		end
	end

	assign q = state;

endmodule
