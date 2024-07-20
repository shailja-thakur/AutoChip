module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00,  // initial state
		S1 = 2'b01,  // state after seeing '1'
		S2 = 2'b10   // state after seeing '10'
	} state_t;
	
	state_t state, next_state;
	
	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			S0:     next_state = x ? S1 : S0;
			S1:     next_state = x ? S1 : S2;
			S2:     next_state = x ? S1 : S0;
			default: next_state = S0; 
		endcase
	end

	// Synchronous state transition
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		case (state)
			S0:     z = 1'b0;
			S1:     z = 1'b0;
			S2:     z = x ? 1'b1 : 1'b0;
			default: z = 1'b0; 
		endcase
	end

endmodule
