module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg next_state;

always @(posedge clk) begin
	if (reset)
		state <= 3'b000; // reset to state A
	else
		state <= next_state;
end

always @(state or w) begin
	case (state)
		3'b000: // state A
			if (w)
				next_state = 3'b000; // transition to state A
			else
				next_state = 3'b001; // transition to state B
		3'b001: // state B
			if (w)
				next_state = 3'b011; // transition to state D
			else
				next_state = 3'b010; // transition to state C
		3'b010: // state C
			if (w)
				next_state = 3'b011; // transition to state D
			else
				next_state = 3'b100; // transition to state E
		3'b011: // state D
			if (w)
				next_state = 3'b000; // transition to state A
			else
				next_state = 3'b101; // transition to state F
		3'b100: // state E
			if (w)
				next_state = 3'b011; // transition to state D
			else
				next_state = 3'b100; // transition to state E
		3'b101: // state F
			if (w)
				next_state = 3'b011; // transition to state D
			else
				next_state = 3'b010; // transition to state C
		default:
			next_state = 3'b000; // default transition to state A
	endcase
end

assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
