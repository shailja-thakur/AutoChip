module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b000;  // Initializing state to A
		else
		begin
			case (state)
				3'b000:  // State A
				begin
					if (x)
						state <= 3'b001;  // Transition to state B
					else
						state <= 3'b000;  // Remain in state A
				end

				3'b001:  // State B
				begin
					if (x)
						state <= 3'b100;  // Transition to state E
					else
						state <= 3'b001;  // Remain in state B
				end

				3'b010:  // State C
				begin
					if (x)
						state <= 3'b001;  // Transition to state B
					else
						state <= 3'b010;  // Remain in state C
				end

				3'b011:  // State D
				begin
					if (x)
						state <= 3'b010;  // Transition to state C
					else
						state <= 3'b001;  // Remain in state B
				end

				3'b100:  // State E
				begin
					if (x)
						state <= 3'b100;  // Remain in state E
					else
						state <= 3'b011;  // Transition to state D
				end

				default:  // Catch-all condition
				begin
					state <= 3'b000;  // Transition to state A
				end
			endcase
		end
	end

	always @(state)
	begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1;  // Output is high when state is D or E
		else
			z <= 1'b0;
	end

endmodule
