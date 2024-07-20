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
			state <= 2'b0;
		else
			state <= next_state;
	end

	always @(state, x)
	begin
		case(state)
			2'b0:
				if (x == 1'b1)
					next_state <= 2'b1;
				else
					next_state <= 2'b0;
			2'b1:
				if (x == 1'b0)
					next_state <= 2'b2;
				else
					next_state <= 2'b0;
			2'b2:
				if (x == 1'b1)
					next_state <= 2'b1;
				else
					next_state <= 2'b0;
			default: next_state <= 2'b0;
		endcase
	end

	always @(posedge clk or negedge aresetn)
	begin
		if (~aresetn)
			z <= 1'b0;
		else
		begin
			if (state == 2'b2)
				z <= 1'b1;
			else
				z <= 1'b0;
		end
	end
endmodule
