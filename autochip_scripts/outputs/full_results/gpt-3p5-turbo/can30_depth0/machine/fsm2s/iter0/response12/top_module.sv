module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @(state or j or k) begin
	case (state)
		2'b00: // state A
			if (j)
				next_state = 2'b01;
			else
				next_state = 2'b00;
		2'b01: // state B
			if (k)
				next_state = 2'b00;
			else
				next_state = 2'b01;
	endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
