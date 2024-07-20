module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;

// State register
always @(posedge clk, posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;
end

// Next state logic
always @(*) begin
	case (state)
		2'b00: next_state = (in) ? 2'b01 : 2'b00;
		2'b01: next_state = (in) ? 2'b01 : 2'b10;
		2'b10: next_state = (in) ? 2'b11 : 2'b00;
		2'b11: next_state = (in) ? 2'b01 : 2'b10;
		default: next_state = 2'b00;
	endcase
end

// Output logic
assign out = (state == 2'b11);

endmodule
