module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
wire out;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b10; // B state
	else
		case (state)
			2'b00: // A state
				if (in)
					state <= 2'b01; // Stay in A state
				else
					state <= 2'b10; // Transition to B state
			2'b01: // B state
				if (in)
					state <= 2'b01; // Stay in B state
				else
					state <= 2'b10; // Transition to A state
			default: state <= 2'b10; // Reset to B state
		endcase
end

assign out = (state == 2'b00) ? 1'b0 : 1'b1;

endmodule
