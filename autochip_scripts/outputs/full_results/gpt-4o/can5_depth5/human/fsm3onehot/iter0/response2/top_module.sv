module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// Output logic
	assign out = state[3]; // Since only state D has output 1, corresponding to state[3] being 1

	always @(*) begin
		case(state)
			4'b0001: next_state = in ? 4'b0010 : 4'b0001; // State A: if in=1 -> B else A
			4'b0010: next_state = in ? 4'b0010 : 4'b0100; // State B: if in=1 -> B else C
			4'b0100: next_state = in ? 4'b1000 : 4'b0001; // State C: if in=1 -> D else A
			4'b1000: next_state = in ? 4'b0010 : 4'b0100; // State D: if in=1 -> B else C
			default: next_state = 4'b0001; // Default to state A
		endcase
	end
endmodule
