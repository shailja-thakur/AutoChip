module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state, next_state;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;  // init state
	else
		state <= next_state;
end

always @(state or in) begin
	case(state)
		0: begin  // BYTE1 state
			if (in[2] == 1'b1)
				next_state = 2'b01;  // transition to BYTE2
			else
				next_state = 2'b00;  // remain in BYTE1
		end
		1: next_state = 2'b10;  // transition to BYTE3 from BYTE2
		2: begin  // BYTE3 state
			if (in[2] == 1'b1)
				next_state = 2'b01;  // transition to BYTE2 from DONE
			else
				next_state = 2'b11;  // transition to DONE from BYTE3
		end
		3: begin  // DONE state
			if (in[2] == 1'b1)
				next_state = 2'b10;  // transition to BYTE3
			else
				next_state = 2'b00;  // transition to BYTE1
		end
		default: next_state = 2'b00;  // default state is BYTE1
	endcase

	if (state == 2'b11)  // DONE state
		done = 1'b1;
	else
		done = 1'b0;
end

endmodule
