module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	// Feedback taps
	reg tap1, tap2;
	
	// Internal shift register
	reg [4:0] shift_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			shift_reg <= 5'b1;
		else begin
			tap1 <= shift_reg[3];
			tap2 <= shift_reg[4];
			
			// Calculate next state
			shift_reg <= {shift_reg[2:0], tap1 ^ tap2};
		end
	end
	
	assign q = shift_reg;
	
endmodule
