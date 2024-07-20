module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	reg [1:0] state;
	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	always @(posedge clk, posedge areset)
	begin
		if (areset)
			state <= OFF;
		else
		begin
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

	always @(state)
	begin
		case (state)
			ON: out <= 1'b1;
			OFF: out <= 1'b0;
		endcase
	end

endmodule
