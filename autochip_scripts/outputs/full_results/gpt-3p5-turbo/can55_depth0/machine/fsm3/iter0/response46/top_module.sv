module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00; // Reset to state A
		out <= 0; // Set output signal to 0
	end else begin
		case (state)
			2'b00: if (in) state <= 2'b01; else state <= 2'b00; // Transition from state A to B or stay in A
			2'b01: if (in) state <= 2'b01; else state <= 2'b10; // Transition from state B to B or to C
			2'b10: if (in) state <= 2'b11; else state <= 2'b00; // Transition from state C to D or to A
			2'b11: if (in) state <= 2'b01; else state <= 2'b10; // Transition from state D to B or to C
			default: state <= 2'b00;
		endcase
		
		if (state == 2'b11) out <= 1; // Set output signal to 1 when in state D
		else out <= 0; // Set output signal to 0 for other states
	end
end

endmodule
