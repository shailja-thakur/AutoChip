module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// Declare internal signals
	reg [1:0] state_next, state_reg;
	
	// Assign initial state
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state_reg <= 2'b0; // OFF state
		else
			state_reg <= state_next;
	end
	
	// Assign next state
	always @(*)
	begin
		case (state_reg)
			2'b00: // OFF state
				if (j)
					state_next = 2'b01; // Transition to ON state if j=1
				else
					state_next = 2'b00; // Stay in OFF state if j=0
			
			2'b01: // ON state
				if (k)
					state_next = 2'b00; // Transition to OFF state if k=1
				else
					state_next = 2'b01; // Stay in ON state if k=0
			
			default: state_next = 2'b0; // Default state is OFF state
		endcase
	end
	
	// Assign output
	always @(state_reg)
	begin
		case (state_reg)
			2'b01: out = 1'b1; // ON state - out=1
			default: out = 1'b0; // OFF state - out=0
		endcase
	end
endmodule
