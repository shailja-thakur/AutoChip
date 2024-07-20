module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state, next_state;

always @(reset, clk) begin
	if (reset)
		state <= 3'b001; // Initialize state to A
	else
		state <= next_state;
end

always @(state, x) begin
	case (state)
		3'b000: // A state
			if (x)
				next_state = 3'b010; // Next state B
			else
				next_state = 3'b000; // Next state A
		3'b001: // B state
			if (x)
				next_state = 3'b100; // Next state E
			else
				next_state = 3'b001; // Next state B
		3'b010: // C state
			if (x)
				next_state = 3'b001; // Next state B
			else
				next_state = 3'b010; // Next state C
		3'b011: // D state
			if (x)
				next_state = 3'b010; // Next state C
			else
				next_state = 3'b011; // Next state D
		3'b100: // E state
			if (x)
				next_state = 3'b100; // Next state E
			else
				next_state = 3'b110; // Next state D
	endcase
end

always @(posedge clk) begin
	if (state == 3'b100 || state == 3'b101)
		z <= 1'b1; // Set output high if state is D or E
	else
		z <= 1'b0; // Set output low for other states
end

endmodule
