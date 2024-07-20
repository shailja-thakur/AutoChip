module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State declaration and assignment
	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset to state A
		end else begin
			case (state)
				2'b00: if (in) state <= 2'b01; else state <= 2'b00; // Current state is A
				2'b01: if (in) state <= 2'b01; else state <= 2'b10; // Current state is B
				2'b10: if (in) state <= 2'b11; else state <= 2'b00; // Current state is C
				2'b11: if (in) state <= 2'b01; else state <= 2'b10; // Current state is D
			endcase
		end
	end

	// Output assignment
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
