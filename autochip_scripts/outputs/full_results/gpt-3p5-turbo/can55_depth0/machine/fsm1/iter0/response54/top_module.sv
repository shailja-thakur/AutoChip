module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset)
begin
	if(areset)
		state <= 2'b0;  // Reset to state B
	else
		state <= next_state;
end

always @*
begin
	case(state)
		2'b00:  // State A
			if(in)
				next_state = 2'b00;  // Stay in state A
			else
				next_state = 2'b01;  // Transition to state B
		2'b01:  // State B
			if(in)
				next_state = 2'b01;  // Stay in state B
			else
				next_state = 2'b00;  // Transition to state A
	endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
