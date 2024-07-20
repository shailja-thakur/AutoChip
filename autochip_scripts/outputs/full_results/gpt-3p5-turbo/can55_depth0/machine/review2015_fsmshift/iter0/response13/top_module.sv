module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [2:0] state;
	// Initialize state to B0 when reset is 1
	// Otherwise, assign nextState to state
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			state <= nextState;
		end
	end

	// nextState logic based on current state
	assign nextState = (reset) ? 3'b000 :
						(state == 3'b000) ? 3'b001 :
						(state == 3'b001) ? 3'b010 :
						(state == 3'b010) ? 3'b011 :
						(state == 3'b011) ? 3'b100 :
						3'b100; // Default to Done state

	// shift_ena output
	assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) ? 1'b1 : 1'b0;

endmodule
