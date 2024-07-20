module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initial state A
		else begin
			case (state)
				3'b000: begin // State A
					if (w)
						state <= 3'b001; // Transition to state B
					else
						state <= 3'b000; // Remain in state A
				end
				3'b001: begin // State B
					if (w)
						state <= 3'b010; // Transition to state C
					else
						state <= 3'b100; // Transition to state D
				end
				3'b010: begin // State C
					if (w)
						state <= 3'b100; // Transition to state E
					else
						state <= 3'b100; // Remain in state C
				end
				3'b100: begin // State D
					if (w)
						state <= 3'b111; // Transition to state F
					else
						state <= 3'b000; // Transition to state A
				end
				3'b011: begin // State E
					if (w)
						state <= 3'b011; // Remain in state E
					else
						state <= 3'b100; // Transition to state D
				end
				3'b111: begin // State F
					if (w)
						state <= 3'b010; // Transition to state C
					else
						state <= 3'b100; // Transition to state D
				end
			endcase
		end
	end
	
	assign z = (state == 3'b011) || (state == 3'b111);
endmodule
