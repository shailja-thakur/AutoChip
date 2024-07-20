module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	reg [1:0] state;
	 
	always @(posedge clk or posedge reset)
		begin
			if (reset)
				state <= 2'b00; // Reset to state A
			else if (state == 2'b00 && in == 1'b0)
				state <= 2'b0; // Next state A
			else if (state == 2'b00 && in == 1'b1)
				state <= 2'b01; // Next state B
			else if (state == 2'b01 && in == 1'b0)
				state <= 2'b01; // Next state B
			else if (state == 2'b01 && in == 1'b1)
				state <= 2'b10; // Next state C
			else if (state == 2'b10 && in == 1'b0)
				state <= 2'b00; // Next state A
			else if (state == 2'b10 && in == 1'b1)
				state <= 2'b11; // Next state D
			else if (state == 2'b11 && in == 1'b0)
				state <= 2'b10; // Next state C
			else if (state == 2'b11 && in == 1'b1)
				state <= 2'b01; // Next state B
		end
		
	always @(state)
		begin
			case(state)
				2'b00: out = 1'b0; // Output for state A
				2'b01: out = 1'b0; // Output for state B
				2'b10: out = 1'b0; // Output for state C
				2'b11: out = 1'b1; // Output for state D
			endcase
		end
endmodule
