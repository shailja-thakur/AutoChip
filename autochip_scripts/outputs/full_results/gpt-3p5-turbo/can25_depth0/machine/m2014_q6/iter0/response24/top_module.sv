module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	
	reg [2:0] state;
	
	always @(posedge clk) begin
		if (reset)
			state <= 3'b000;  // Reset to state A
		else begin
			case (state)
				3'b000:  // State A
					if (w)
						state <= 3'b000;  // Stay in state A
					else
						state <= 3'b001;  // Transition to state B
				3'b001:  // State B
					if (w)
						state <= 3'b011;  // Transition to state D
					else
						state <= 3'b010;  // Transition to state C
				3'b010:  // State C
					if (w)
						state <= 3'b011;  // Transition to state D
					else
						state <= 3'b100;  // Transition to state E
				3'b011:  // State D
					if (w)
						state <= 3'b000;  // Transition to state A
					else
						state <= 3'b101;  // Transition to state F
				3'b100:  // State E
					if (w)
						state <= 3'b011;  // Transition to state D
					else
						state <= 3'b100;  // Stay in state E
				3'b101:  // State F
					if (w)
						state <= 3'b011;  // Transition to state D
					else
						state <= 3'b010;  // Transition to state C
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			3'b100, 3'b101:
				z <= 1'b1;  // Output z is high
			default:
				z <= 1'b0;  // Output z is low
		endcase
	end
	
endmodule
