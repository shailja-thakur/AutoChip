module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initialize state to A
		else begin
			case (state)
				3'b000: begin // State A
					if (x)
						state <= 3'b001; // Transition to state B
					else
						state <= 3'b000; // Remain in state A
				end
				3'b001: begin // State B
					if (x)
						state <= 3'b100; // Transition to state E
					else
						state <= 3'b001; // Remain in state B
				end
				3'b010: begin // State C
					if (x)
						state <= 3'b001; // Transition to state B
					else
						state <= 3'b010; // Remain in state C
				end
				3'b011: begin // State D
					if (x)
						state <= 3'b010; // Transition to state C
					else
						state <= 3'b001; // Remain in state B
				end
				3'b100: begin // State E
					if (x)
						state <= 3'b100; // Remain in state E
					else
						state <= 3'b011; // Transition to state D
				end
				default: state <= 3'b000; // Default case (shouldn't occur)
			endcase
		end
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			z <= 0; // Initialize output to low
		else begin
			case (state)
				3'b011: z <= 1; // Output high when state is D
				3'b100: z <= 1; // Output high when state is E
				default: z <= 0; // Output low for all other states
			endcase
		end
	end

endmodule
