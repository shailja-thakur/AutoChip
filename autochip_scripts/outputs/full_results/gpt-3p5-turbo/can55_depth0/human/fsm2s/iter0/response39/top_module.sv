module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state, next_state;

	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	assign out = (state == OFF) ? 1'b0 : 1'b1;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end

	always @*
	begin
		case(state)
			OFF:
			begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end

			ON:
			begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
		endcase
	end

endmodule
