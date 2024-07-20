module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk) begin
		if (areset == 1'b1)
			state <= 2'b00; // Reset to state A
		else begin
			case(state)
				2'b00: state <= (in == 1'b1) ? 2'b10: 2'b00; // Current state A, next state B if input is 1, A if input is 0
				2'b01: state <= (in == 1'b1) ? 2'b01: 2'b10; // Current state B, next state B if input is 1, C if input is 0
				2'b10: state <= (in == 1'b1) ? 2'b11: 2'b00; // Current state C, next state D if input is 1, A if input is 0
				2'b11: state <= (in == 1'b1) ? 2'b01: 2'b10; // Current state D, next state B if input is 1, C if input is 0
			endcase
		end
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Set out to 1 if state is D

endmodule
