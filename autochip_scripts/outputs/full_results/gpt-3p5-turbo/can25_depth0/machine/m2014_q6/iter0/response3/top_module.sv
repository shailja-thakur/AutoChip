module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	// Registers to hold the current and next state
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	// Combintational logic to determine next state based on current state and input w
	always @(posedge clk) begin
		if (reset)
			current_state <= 3'b000; // Initialize to state A
		else
			current_state <= next_state;
	end
	
	// Assign next state based on current state and input w
	always @* begin
		case (current_state)
			3'b000: next_state = (w) ? 3'b000 : 3'b001; // Transition from A to A or B
			3'b001: next_state = (w) ? 3'b010 : 3'b011; // Transition from B to D or C
			3'b010: next_state = (w) ? 3'b011 : 3'b100; // Transition from C to D or E
			3'b011: next_state = (w) ? 3'b000 : 3'b101; // Transition from D to A or F
			3'b100: next_state = (w) ? 3'b100 : 3'b101; // Transition from E to D or E
			3'b101: next_state = (w) ? 3'b010 : 3'b001; // Transition from F to C or B
			default: next_state = 3'b000; // Default case, should never happen
		endcase
	end
	
	// Output logic
	assign z = (current_state == 3'b100 || current_state == 3'b101) ? 1'b1 : 1'b0; // z is high in state E or F, low otherwise
	
endmodule
