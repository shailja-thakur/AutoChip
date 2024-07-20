module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

// state enumeration
typedef enum logic [1:0] {
	BYTE1,
	BYTE2,
	BYTE3,
	DONE
} state_type;

// initialize state variable
reg state_type current_state, next_state;

// state transition logic
always_ff @(posedge clk, posedge reset)
begin
	if (reset)
		current_state <= BYTE1;
	else
		current_state <= next_state;
end

// state logic
always_comb
begin
	case (current_state)
		BYTE1:
			if (in[2] == 1'b1)
				next_state = BYTE2;
			else
				next_state = BYTE1;
			
		BYTE2:
			next_state = BYTE3;
			
		BYTE3:
			next_state = DONE;
			
		DONE:
			if (in[2] == 1'b1)
				next_state = BYTE2;
			else
				next_state = BYTE1;
	endcase
end

// done signal logic
always_comb
begin
	if (current_state == DONE)
		done = 1'b1;
	else
		done = 1'b0;
end

endmodule
