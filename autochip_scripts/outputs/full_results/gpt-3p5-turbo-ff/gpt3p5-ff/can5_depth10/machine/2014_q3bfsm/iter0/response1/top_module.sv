module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Set state to A on reset
		else begin
			case (state)
				3'b000: begin // A state
						if (x)
							state <= 3'b001; // Transition to B state when x is high
						else
							state <= 3'b000; // Remain in A state when x is low
					end
				3'b001: begin // B state
						if (x)
							state <= 3'b100; // Transition to E state when x is high
						else
							state <= 3'b001; // Remain in B state when x is low
					end
				3'b010: begin // C state
						if (x)
							state <= 3'b001; // Transition to B state when x is high
						else
							state <= 3'b010; // Remain in C state when x is low
					end
				3'b011: begin // D state
						if (x)
							state <= 3'b010; // Transition to C state when x is high
						else
							state <= 3'b010; // Transition to B state when x is low
					end
				3'b100: begin // E state
						if (x)
							state <= 3'b100; // Remain in E state when x is high
						else
							state <= 3'b011; // Transition to D state when x is low
					end
			endcase
		end
	end

	always @(state) begin
		// Output '1' when state is D or E, otherwise '0'
		if (state == 3'b011 || state == 3'b100)
			z <= 1'b1; // High output
		else
			z <= 1'b0; // Low output
	end

endmodule
