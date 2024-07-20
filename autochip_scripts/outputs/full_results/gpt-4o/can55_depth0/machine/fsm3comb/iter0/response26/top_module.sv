module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always @(*) begin
	case (state)
		2'b00: // State A
			if (in)
				next_state = 2'b01; // go to State B
			else
				next_state = 2'b00; // remain in State A
		2'b01: // State B
			if (in)
				next_state = 2'b01; // remain in State B
			else
				next_state = 2'b10; // go to State C
		2'b10: // State C
			if (in)
				next_state = 2'b11; // go to State D
			else
				next_state = 2'b00; // go to State A
		2'b11: // State D
			if (in)
				next_state = 2'b01; // go to State B
			else
				next_state = 2'b10; // go to State C
		default: next_state = 2'b00; // Default to State A
	endcase
end

always @(*) begin
	if (state == 2'b11)
		out = 1;
	else
		out = 0;
end

endmodule
