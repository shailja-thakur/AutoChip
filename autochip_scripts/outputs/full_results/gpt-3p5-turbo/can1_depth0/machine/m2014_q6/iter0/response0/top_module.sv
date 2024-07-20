module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;  // Define a 3-bit register to hold the current state of the state machine

always @(posedge clk) begin
	if (reset) begin
		state <= 3'b000;  // If reset is high, reset the state machine to state A
	end else begin
		case (state)
			3'b000: if (w) state <= 3'b000;  // Transition from state A to A when w is high
				 else state <= 3'b001;  // Transition from state A to B when w is low
			
			3'b001: if (w) state <= 3'b010;  // Transition from state B to D when w is high
				 else state <= 3'b010;  // Transition from state B to C when w is low
			
			3'b010: if (w) state <= 3'b010;  // Transition from state C to D when w is high
				 else state <= 3'b011;  // Transition from state C to E when w is low
			
			3'b011: if (w) state <= 3'b000;  // Transition from state D to A when w is high
				 else state <= 3'b101;  // Transition from state D to F when w is low
			
			3'b101: if (w) state <= 3'b010;  // Transition from state F to D when w is high
				 else state <= 3'b010;  // Transition from state F to C when w is low
			
			default: state <= 3'b010;  // For all other states, transition to state D
		endcase
	end
end

assign z = (state == 3'b011 || state == 3'b101);  // Output z is high when the state machine is in state E or F, and low otherwise

endmodule
