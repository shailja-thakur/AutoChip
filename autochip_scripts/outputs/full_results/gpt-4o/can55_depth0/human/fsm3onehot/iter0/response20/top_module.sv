module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// State transition logic
	always @(*) begin
		case (state)
			4'b0001: next_state = in ? 4'b0010 : 4'b0001; // A: in=0 -> A, in=1 -> B
			4'b0010: next_state = in ? 4'b0010 : 4'b0100; // B: in=0 -> C, in=1 -> B
			4'b0100: next_state = in ? 4'b1000 : 4'b0001; // C: in=0 -> A, in=1 -> D
			4'b1000: next_state = in ? 4'b0010 : 4'b0100; // D: in=0 -> C, in=1 -> B
			default: next_state = 4'b0001; // Default to state A for undefined states
		endcase
	end

	// Output logic
	assign out = (state == 4'b1000); // Only state D produces output 1, rest are 0

endmodule
