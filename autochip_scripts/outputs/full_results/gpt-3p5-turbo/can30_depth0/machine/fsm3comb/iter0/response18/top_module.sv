module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

	// Declare internal signals
	reg [1:0] current_state;
	reg out_reg;
	
	// Assign current state based on state input
	always @(*) begin
		current_state = state;
	end
	
	// State transition logic
	always_comb begin
		case (current_state)
			2'b00: begin  // State A
				if (in)
					next_state = 2'b01;  // Transition to state B
				else
					next_state = 2'b00;  // Remain in state A
			end
			
			2'b01: begin  // State B
				if (in)
					next_state = 2'b01;  // Remain in state B
				else
					next_state = 2'b10;  // Transition to state C
			end
			
			2'b10: begin  // State C
				if (in)
					next_state = 2'b11;  // Transition to state D
				else
					next_state = 2'b00;  // Transition to state A
			end
			
			2'b11: begin  // State D
				if (in)
					next_state = 2'b01;  // Transition to state B
				else
					next_state = 2'b10;  // Transition to state C
			end
			
			default: begin
				next_state = 2'b00;  // Default to state A
			end
		endcase
	end
	
	// Assign out signal based on current state
	always @(*) begin
		case (current_state)
			2'b11: out_reg = 1'b1;  // State D
			default: out_reg = 1'b0;  // Other states
		endcase
	end
	
	// Assign reg signals to output ports
	assign out = out_reg;
	assign state = current_state;
endmodule
