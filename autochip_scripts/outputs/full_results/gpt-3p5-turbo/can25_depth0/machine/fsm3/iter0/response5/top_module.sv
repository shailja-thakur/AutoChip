module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;  // reset to state A
	else
		state <= next_state;
end

always @* begin
	case (state)
		2'b00: begin  // state A
			if (in)
				next_state = 2'b01;  // transition to state B
			else
				next_state = 2'b00;  // stay in state A
		end
		2'b01: begin  // state B
			if (in)
				next_state = 2'b01;  // stay in state B
			else
				next_state = 2'b10;  // transition to state C
		end
		2'b10: begin  // state C
			if (in)
				next_state = 2'b11;  // transition to state D
			else
				next_state = 2'b00;  // transition to state A
		end
		2'b11: begin  // state D
			if (in)
				next_state = 2'b01;  // transition to state B
			else
				next_state = 2'b10;  // transition to state C
		end
		default: next_state = 2'b00;  // default to state A
	endcase
end

assign out = (state == 2'b11);  // out is 1 when state is D

endmodule
