module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always_comb begin
	case (state)
		2'b00: // State A
			if (in == 1'bx) begin
				next_state = 2'b01; // Next state B
			end else begin
				next_state = 2'b00; // Next state A
			end
		2'b01: // State B
			if (in == 1'bx) begin
				next_state = 2'b01; // Next state B
			end else begin
				next_state = 2'b10; // Next state C
			end
		2'b10: // State C
			if (in == 1'bx) begin
				next_state = 2'b11; // Next state D
			end else begin
				next_state = 2'b00; // Next state A
			end
		2'b11: // State D
			if (in == 1'bx) begin
				next_state = 2'b01; // Next state B
			end else begin
				next_state = 2'b10; // Next state C
			end
	endcase
end

always_ff @(posedge clk) begin // Assuming the use of a clock signal
	if (state == 2'b11) begin // State D
		out = 1'b1; // Signal that the state machine is in state D
	else
		out = 1'b0;
	end
end

endmodule
