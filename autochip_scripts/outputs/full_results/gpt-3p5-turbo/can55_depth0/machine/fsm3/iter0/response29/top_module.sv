module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State register
	reg [1:0] state;

	// Next state logic
	always @ (posedge clk or posedge areset)
	begin
		// Reset state to A on rising edge of areset
		if (areset)
			state <= 2'b00;
		// Update state on rising edge of clk
		else if (clk)
		begin
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00; // A
				2'b01: state <= (in) ? 2'b01 : 2'b10; // B
				2'b10: state <= (in) ? 2'b11 : 2'b00; // C
				2'b11: state <= (in) ? 2'b01 : 2'b10; // D
			endcase
		end
	end

	// Output logic
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
