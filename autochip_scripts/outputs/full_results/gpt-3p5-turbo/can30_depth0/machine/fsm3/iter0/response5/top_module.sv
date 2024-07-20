module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // Reset to state A
		else begin
			case (state)
				2'b00: // State A
					if (in)
						state <= 2'b01; // Next state B
					else
						state <= 2'b00; // Next state A
				2'b01: // State B
					if (in)
						state <= 2'b01; // Next state B
					else
						state <= 2'b10; // Next state C
				2'b10: // State C
					if (in)
						state <= 2'b11; // Next state D
					else
						state <= 2'b00; // Next state A
				2'b11: // State D
					if (in)
						state <= 2'b01; // Next state B
					else
						state <= 2'b10; // Next state C
			endcase
		end
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Set out to 1 when state is D
	
endmodule
