module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b0; // Initializing state to A when reset is high
		else begin
			case (state)
				3'b000: begin // State A
					if (x)
						state <= 3'b001; // Transition to state B
					// else state remains A
				end
				
				3'b001: begin // State B
					if (x)
						state <= 3'b101; // Transition to state E
					// else state remains B
				end
				
				3'b010: begin // State C
					if (x)
						state <= 3'b001; // Transition to state B
					// else state remains C
				end
				
				3'b011: begin // State D
					if (x)
						state <= 3'b010; // Transition to state C
					// else state remains D
				end
				
				3'b100: begin // State E
					if (x)
						state <= 3'b100; // Transition to state D
					// else state remains E
				end
			endcase
		end
	end
	
	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1; // Output is high when state is D or E
		else
			z <= 1'b0;
	end
endmodule
