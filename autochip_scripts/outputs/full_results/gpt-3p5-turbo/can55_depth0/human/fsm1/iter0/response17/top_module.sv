module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
wire reset;

assign reset = areset; // asynchronously reset

always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= 2'b0; // reset to state B
	else
		state <= next_state;
end

always @*
begin
	case (state)
		2'b00: begin // State B
			if (in)
				next_state = 2'b01; // Next state A
			else
				next_state = 2'b00; // Next state B
		end

		2'b01: begin // State A
			if (in)
				next_state = 2'b01; // Next state A
			else
				next_state = 2'b00; // Next state B
		end

		default: next_state = 2'b00; // Default state B
	endcase
end

assign out = state[1];

endmodule
