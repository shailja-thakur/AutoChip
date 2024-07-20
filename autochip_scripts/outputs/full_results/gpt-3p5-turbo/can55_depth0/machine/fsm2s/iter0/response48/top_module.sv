module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg[1:0] state;
reg next_state;

always @(posedge clk) begin
	if (reset)
		state <= 2'b00; // initial state A
	else
		state <= next_state;
end

always @* begin
	case(state)
		2'b00: begin // state A
			if (j)
				next_state = 2'b01; // transition to state B if j is high
			else
				next_state = 2'b00; // remain in state A if j is low
		end
		2'b01: begin // state B
			if (k)
				next_state = 2'b00; // transition to state A if k is high
			else
				next_state = 2'b01; // remain in state B if k is low
		end
	endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // output is high when state is B, and low when state is A

endmodule
