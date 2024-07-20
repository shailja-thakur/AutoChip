module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

// Define the state machine transitions
reg [6:1] next_state;

always @ (*) begin
	case(y)
		6'b000001: next_state = 6'b000010; // A (0) --0--> B
		6'b000010: next_state = 6'b000001; // A (0) --1--> A
		6'b000100: next_state = 6'b001000; // B (0) --0--> C
		6'b000100: next_state = 6'b001001; // B (0) --1--> D
		6'b001000: next_state = 6'b010000; // C (0) --0--> E
		6'b001000: next_state = 6'b001001; // C (0) --1--> D
		6'b001001: next_state = 6'b100000; // D (0) --0--> F
		6'b001001: next_state = 6'b000001; // D (0) --1--> A
		6'b010000: next_state = 6'b010000; // E (1) --0--> E
		6'b010000: next_state = 6'b001001; // E (1) --1--> D
		6'b100000: next_state = 6'b001000; // F (1) --0--> C
		6'b100000: next_state = 6'b001001; // F (1) --1--> D
		default: next_state = 6'b000001; // Resets to state A
	endcase
end

// Derive the logic equations for Y2 and Y4 using one-hot encoding
assign Y2 = (next_state[2] & ~w) | (next_state[4] & w);
assign Y4 = (next_state[4] & ~w) | (next_state[2] & w);

endmodule
