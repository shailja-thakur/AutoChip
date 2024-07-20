module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b0; // Initializing state to A
		else begin
			case (state)
				3'b000: begin // State A
						if (x == 1'b0)
							state <= 3'b000; // Stay in state A
						else if (x == 1'b1)
							state <= 3'b001; // Transition to state B
					end
				3'b001: begin // State B
						if (x == 1'b0)
							state <= 3'b001; // Stay in state B
						else if (x == 1'b1)
							state <= 3'b100; // Transition to state E
					end
				3'b010: begin // State C
						if (x == 1'b0)
							state <= 3'b010; // Stay in state C
						else if (x == 1'b1)
							state <= 3'b001; // Transition to state B
					end
				3'b011: begin // State D
						if (x == 1'b0)
							state <= 3'b001; // Transition to state B
						else if (x == 1'b1)
							state <= 3'b010; // Transition to state C
					end
				3'b100: begin // State E
						if (x == 1'b0)
							state <= 3'b011; // Transition to state D
						else if (x == 1'b1)
							state <= 3'b100; // Stay in state E
					end
				default: state <= 3'b0; // Default to state A
			endcase
		end
	end
	
	always @(posedge clk) begin
		// Output is high when the state is D or E
		if (state == 3'b011 || state == 3'b100)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
	
endmodule
