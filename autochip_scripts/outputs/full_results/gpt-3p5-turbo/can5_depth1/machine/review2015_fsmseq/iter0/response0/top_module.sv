module top_module (
    input clk,
    input reset,
    input data,
    output start_shifting
);

	// Define states
	typedef enum logic [2:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_type;
	
	// Define registers
	reg state_type state, next_state;
	reg start_shifting_reg;

	// Combinational logic block to determine next state
	always_comb begin
		case(state)
			S: begin
				if (data)
				    next_state = S1;
				else
				    next_state = S;
			end
			S1: begin
				if (data)
				    next_state = S11;
				else
				    next_state = S;
			end
			S11: begin
				if (data)
				    next_state = S11;
				else
				    next_state = S110;
			end
			S110: begin
				if (data)
				    next_state = Done;
				else
				    next_state = S;
			end
			Done: next_state = Done;
		endcase
	end

	// State transition process triggered on the rising edge of clk
	always_ff @(posedge clk) begin
		if (reset)
		    state <= S;
		else
		    state <= next_state;
	end

	// Output assignment based on the current state
	assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

endmodule
