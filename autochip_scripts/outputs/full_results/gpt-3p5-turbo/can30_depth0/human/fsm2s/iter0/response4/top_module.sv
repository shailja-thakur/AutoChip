module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	reg state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= OFF;
		else
			case (state)
				OFF: begin
					if (j)
						state <= ON;
					else
						state <= OFF;
				end
				ON: begin
					if (k)
						state <= OFF;
					else
						state <= ON;
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			OFF: out <= 0;
			ON: out <= 1;
		endcase
	end

endmodule
