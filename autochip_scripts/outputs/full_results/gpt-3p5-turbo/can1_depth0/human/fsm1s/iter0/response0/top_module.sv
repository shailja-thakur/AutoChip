module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
wire next_state;

always @(posedge clk, posedge reset)
begin
	if (reset)
		state <= 2'b10;
	else
		state <= next_state;
end

always @(state, in)
begin
	case (state)
		2'b10: begin // State B
			if (in)
				next_state = 2'b10; // Stay in state B
			else
				next_state = 2'b01; // Transition to state A
			out = 1;
		end
		
		2'b01: begin // State A
			if (in)
				next_state = 2'b01; // Stay in state A
			else
				next_state = 2'b10; // Transition to state B
			out = 0;
		end
	endcase
end

endmodule
