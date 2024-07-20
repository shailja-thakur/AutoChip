module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // Reset to state B
		else begin
			case(state)
				2'b00: begin // State B
					if (in)
						state <= 2'b10; // Transition to state B
					else
						state <= 2'b01; // Transition to state A
				end
				
				2'b01: begin // State A
					if (in)
						state <= 2'b01; // Transition to state A
					else
						state <= 2'b10; // Transition to state B
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			2'b00: out = 1; // Output is 1 in state B
			2'b01: out = 0; // Output is 0 in state A
		endcase
	end
endmodule
