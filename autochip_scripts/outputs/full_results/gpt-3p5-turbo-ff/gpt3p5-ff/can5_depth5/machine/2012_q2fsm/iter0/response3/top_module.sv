module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, next_state; // 3-bit register for states
assign z = (state == 3'b011) || (state == 3'b100); // set z output to 1 when state is E or F

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000; // reset state to initial state A
	else
		state <= next_state; // update state based on next_state
end

always @* begin
	case (state)
		3'b000: // state A
			if (w == 1'b0)
				next_state = 3'b000; // A to A
			else
				next_state = 3'b001; // A to B
		3'b001: // state B
			if (w == 1'b0)
				next_state = 3'b100; // B to D
			else
				next_state = 3'b010; // B to C
		3'b010: // state C
			if (w == 1'b0)
				next_state = 3'b100; // C to D
			else
				next_state = 3'b011; // C to E
		3'b011: // state D
			if (w == 1'b0)
				next_state = 3'b000; // D to A
			else
				next_state = 3'b110; // D to F
		3'b100: // state E
			if (w == 1'b0)
				next_state = 3'b010; // E to C
			else
				next_state = 3'b011; // E to E
		3'b110: // state F
			if (w == 1'b0)
				next_state = 3'b010; // F to C
			else
				next_state = 3'b100; // F to D
	endcase
end

endmodule
