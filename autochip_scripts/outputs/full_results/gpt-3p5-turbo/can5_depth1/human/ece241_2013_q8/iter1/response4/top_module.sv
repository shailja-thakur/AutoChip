module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [1:0] state, next_state;

	always @(posedge clk or negedge aresetn)
	begin
		if (~aresetn)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(state, x)
	begin
		case(state)
			2'b00:
				if (x == 1'b1)
					next_state <= 2'b01;
				else
					next_state <= 2'b00;
			2'b01:
				if (x == 1'b0)
					next_state <= 2'b10;
				else
					next_state <= 2'b00;
			2'b10:
				if (x == 1'b1)
					next_state <= 2'b01;
				else
					next_state <= 2'b00;
			default: next_state <= 2'b00;
		endcase
	end

	always @(state)
	begin
		case(state)
			2'b10:
				z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end
endmodule
