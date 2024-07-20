module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// State enumeration
typedef enum logic [2:0] {
	BYTE1,
	BYTE2,
	BYTE3,
	DONE
} state_t;

reg state, next_state;

always_ff @(posedge clk, posedge reset)
begin
	if (reset)
		state <= BYTE1;
	else
		state <= next_state;
end

always_comb
begin
	// Next state logic
	case (state)
		BYTE1:
			if (in[2] == 1'b0)
				next_state = BYTE1;
			else
				next_state = BYTE2;
		BYTE2:
			next_state = BYTE3;
		BYTE3:
			next_state = DONE;
		DONE:
			if (in[2] == 1'b0)
				next_state = BYTE1;
			else
				next_state = BYTE2;
	endcase

	// Output logic
	done = (state == DONE);
end

endmodule
