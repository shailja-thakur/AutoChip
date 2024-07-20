module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always_comb begin
	case(state)
		2'b00: // State A
			if (in)
				next_state = 2'b01; // State B
			else
				next_state = 2'b00; // State A
		2'b01: // State B
			if (in)
				next_state = 2'b01; // State B
			else
				next_state = 2'b10; // State C
		2'b10: // State C
			if (in)
				next_state = 2'b11; // State D
			else
				next_state = 2'b00; // State A
		2'b11: // State D
			if (in)
				next_state = 2'b01; // State B
			else
				next_state = 2'b10; // State C
	endcase
	
	if (state == 2'b11) // State D
		out = 1'b1;
	else
		out = 1'b0;
end

endmodule
