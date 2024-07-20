module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Define the states
	parameter OFF = 1'b0;
	parameter ON = 1'b1;

	// Define the state register
	reg state;
	
	// Define the next state logic
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF;
		end else begin
			case(state)
				ON: if (k) state <= OFF;
				OFF: if (j) state <= ON;
			endcase
		end
	end
	
	// Define the output logic
	always @(state, j, k) begin
		case(state) 
			ON: out <= 1'b1;
			OFF: out <= 1'b0;
		endcase
	end
			
endmodule
