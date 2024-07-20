module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Internal state
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b001; // Initialize state to A
		end else begin
			case (state)
				3'b000 : begin // State A
					if (x) begin
						state <= 3'b010; // Transition to state B
					else
						state <= 3'b000; // Stay in state A
					end
				end
				
				3'b001 : begin // State B
					if (x) begin
						state <= 3'b101; // Transition to state E
					else
						state <= 3'b001; // Stay in state B
					end
				end
				
				3'b010 : begin // State C
					if (x) begin
						state <= 3'b010; // Stay in state C
					else
						state <= 3'b010; // Stay in state C
					end
				end
				
				3'b011 : begin // State D
					if (x) begin
						state <= 3'b010; // Transition to state C
					else
						state <= 3'b010; // Transition to state C
					end
				end
				
				3'b100 : begin // State E
					if (x) begin
						state <= 3'b100; // Transition to state D
					else
						state <= 3'b100; // Stay in state E
					end
				end
				
				3'b101 : begin // State F
					if (x) begin
						state <= 3'b100; // Transition to state D
					else
						state <= 3'b100; // Transition to state D
					end
				end
				
				default: begin
					state <= 3'b000;
				end
			endcase
		end
		
		// Output logic
		case (state)
			3'b010, 3'b101, 3'b100 : z <= 1'b1; // Output is high in states B, E, and D
			default : z <= 1'b0; // Output is low in all other states
		endcase
	end

endmodule
