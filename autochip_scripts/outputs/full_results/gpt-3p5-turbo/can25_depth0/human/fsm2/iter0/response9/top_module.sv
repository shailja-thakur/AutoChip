module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	parameter OFF = 0;
	parameter ON = 1;

	reg [1:0] state;
	reg out;

	always @(posedge clk or areset)
	begin
		if (areset)
			state <= OFF;
		else
		begin
			case(state)
				ON: begin
						if (k)
							state <= OFF;
						else
							state <= ON;
					end
				OFF:begin
						if (j)
							state <= ON;
						else
							state <= OFF;
					end
				default: state <= OFF;
			endcase
		end
	end

	always @*
	begin
		case(state)
			ON: out = 1;
			OFF: out = 0;
			default: out = 0;
		endcase
	end

endmodule
