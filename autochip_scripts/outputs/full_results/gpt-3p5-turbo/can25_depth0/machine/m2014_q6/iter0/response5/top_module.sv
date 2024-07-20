module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000; // Reset to state A
	else
		state <= next_state; // Transition to next state
end

always @(*) begin
	case(state)
		3'b000: // State A
			if (w)
				next_state = 3'b000; // Transition to state A
			else
				next_state = 3'b001; // Transition to state B
		3'b001: // State B
			if (w)
				next_state = 3'b011; // Transition to state D
			else
				next_state = 3'b010; // Transition to state C
		3'b010: // State C
			if (w)
				next_state = 3'b011; // Transition to state D
			else
				next_state = 3'b100; // Transition to state E
		3'b011: // State D
			if (w)
				next_state = 3'b000; // Transition to state A
			else
				next_state = 3'b101; // Transition to state F
		3'b100: // State E
			if (w)
				next_state = 3'b011; // Transition to state D
			else
				next_state = 3'b100; // Transition to state E
		3'b101: // State F
			if (w)
				next_state = 3'b011; // Transition to state D
			else
				next_state = 3'b010; // Transition to state C
		default:
			next_state = 3'b000;
	endcase
end

assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
