module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states using a 2-bit register
	reg [1:0] state;
	
	// Define the next state logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // Reset to state A
		else begin
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00; // State A
				2'b01: state <= (in) ? 2'b01 : 2'b10; // State B
				2'b10: state <= (in) ? 2'b11 : 2'b00; // State C
				2'b11: state <= (in) ? 2'b01 : 2'b10; // State D
			endcase
		end
	end
	
	// Set output signal to 1 when in state D
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
