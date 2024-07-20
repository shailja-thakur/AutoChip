module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	
	// State parameter definitions
	parameter OFF = 0;
	parameter ON = 1;
	
	// Internal state declaration
	reg [1:0] state;
	
	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			case (state)
				ON: begin
					if (k)
						state <= OFF;
					else
						state <= ON;
					end
				OFF: begin
					if (j)
						state <= ON;
					else
						state <= OFF;
					end
			endcase
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			ON: out <= 1'b1;
			OFF: out <= 1'b0;
		endcase
	end
endmodule
