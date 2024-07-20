module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Internal state representation
	reg [2:0] state;
	// Default state initialization to A
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b001;
		else begin
			case (state)
				3'b001: begin // State A
					if (x)
						state <= 3'b010; // Transition to B
					else
						state <= 3'b001; // Stay in A
				end
				3'b010: begin // State B
					if (x)
						state <= 3'b101; // Transition to E
					else
						state <= 3'b010; // Stay in B
				end
				3'b011: begin // State C
					if (x)
						state <= 3'b010; // Transition to B
					else
						state <= 3'b011; // Stay in C
				end
				3'b100: begin // State D
					if (x)
						state <= 3'b011; // Transition to C
					else
						state <= 3'b010; // Transition to B
				end
				3'b101: begin // State E
					if (x)
						state <= 3'b101; // Stay in E
					else
						state <= 3'b100; // Transition to D
				end
				default: state <= 3'b001; // Default initialization to A
			endcase
		end
	end

	// Output definition
	always @(posedge clk) begin
		case (state)
			3'b100, 3'b101: z <= 1; // State D or E
			default: z <= 0; // All other states
		endcase
	end

endmodule
