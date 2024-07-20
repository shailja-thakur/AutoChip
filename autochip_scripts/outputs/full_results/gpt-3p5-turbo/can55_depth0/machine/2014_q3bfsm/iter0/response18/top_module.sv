module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b0; // Initializing state to A
		else
			state <= next_state; // State transition
	end
	
	always @(state or x)
	begin
		case (state)
			3'b000: // State A
				begin
					if (x)
						next_state = 3'b001; // Next state B
					else
						next_state = 3'b000; // Next state A
				end
			
			3'b001: // State B
				begin
					if (x)
						next_state = 3'b100; // Next state E
					else
						next_state = 3'b001; // Next state B
				end
			
			3'b010: // State C
				begin
					if (x)
						next_state = 3'b001; // Next state B
					else
						next_state = 3'b010; // Next state C
				end
			
			3'b011: // State D
				begin
					if (x)
						next_state = 3'b010; // Next state C
					else
						next_state = 3'b001; // Next state B
				end
			
			3'b100: // State E
				begin
					if (x)
						next_state = 3'b100; // Next state E
					else
						next_state = 3'b011; // Next state D
				end
		endcase
	end
	
	always @(state)
	begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1; // Output is high when state is D or E
		else
			z <= 1'b0;
	end

endmodule
