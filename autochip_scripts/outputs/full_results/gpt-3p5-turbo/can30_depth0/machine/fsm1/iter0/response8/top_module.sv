module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b01; // reset to state B
	else begin
		case (state)
			2'b00: // state A
				if (in)
					state <= 2'b00; // next state is A
				else
					state <= 2'b01; // next state is B
			2'b01: // state B
				if (in)
					state <= 2'b01; // next state is B
				else
					state <= 2'b00; // next state is A
			default:
				state <= 2'b01; // reset to state B
		endcase
	end
end

always @(state) begin
	if (state == 2'b01) // state B
		out = 1'b1;
	else
		out = 1'b0;
end

endmodule
