module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state;
	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= OFF;
		else
		begin
			case (state)
				ON: if (k == 1'b0)
						state <= ON;
				OFF: if (j == 1'b1)
						state <= ON;
				default: state <= OFF;
			endcase
		end
	end

	always @(state)
	begin
		case (state)
			OFF: out = 1'b0;
			ON: out = 1'b1;
			default: out = 1'b0;
		endcase
	end

endmodule
