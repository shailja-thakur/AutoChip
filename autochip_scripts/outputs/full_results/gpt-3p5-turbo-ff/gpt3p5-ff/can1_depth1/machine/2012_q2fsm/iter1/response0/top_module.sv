module top_module (
	input wire clk,
	input wire reset,
	input wire w,
	output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;   // Initial state is A
	else
		state <= next_state;   // Update current state
end

always @* begin
	case (state)
		3'b000:   // State A
			if (w)
				next_state = 3'b001;   // Transition to B
			else
				next_state = 3'b100;   // Transition to D
		3'b001:   // State B
			if (w)
				next_state = 3'b010;   // Transition to C
			else
				next_state = 3'b100;   // Transition to D
		3'b010:   // State C
			if (w)
				next_state = 3'b101;   // Transition to F
			else
				next_state = 3'b100;   // Transition to D
		3'b011:   // State D
			if (w)
				next_state = 3'b001;   // Transition to B
			else
				next_state = 3'b000;   // Transition to A
		3'b100:   // State E
			if (w)
				next_state = 3'b100;   // Transition to E
			else
				next_state = 3'b100;   // Transition to E
		3'b101:   // State F
			if (w)
				next_state = 3'b010;   // Transition to C
			else
				next_state = 3'b010;   // Transition to C
		default:
			next_state = 3'b000;   // Default transition to A
	endcase
end

always @(state) begin
	if (state == 3'b100 || state == 3'b101)
		z = 1'b1;
	else
		z = 1'b0;
end

endmodule
