module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	// State declaration
	reg [1:0] state;
	
	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // State A
		end else begin
			case (state)
				2'b00: // State A
					if (x == 1'b0)
						state <= 2'b00;
					else
						state <= 2'b01; // Transition to state B
						
				2'b01: // State B
					if (x == 1'b1)
						state <= 2'b00; // Transition back to state B
					else
						state <= 2'b01;
			endcase
		end
	end
	
	// Output logic
	always @(state, x) begin
		case (state)
			2'b00: // State A
				z <= 1'b0;
				
			2'b01: // State B
				z <= 1'b1;
		endcase
	end

endmodule
