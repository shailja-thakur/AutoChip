module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(state or w) begin
		case (state)
			2'b00:
				if (s == 1)
					next_state <= 2'b01;
				else
					next_state <= 2'b00;
			2'b01:
				if (w == 1)
					next_state <= 2'b10;
				else
					next_state <= 2'b01;
			2'b10:
				if (w == 1)
					next_state <= 2'b11;
				else
					next_state <= 2'b01;
			2'b11:
				if (w == 1)
					next_state <= 2'b01;
				else
					next_state <= 2'b00;
		endcase
	end

	always @(posedge clk) begin
		if (state == 2'b10 && w == 1)
			z <= 1;
		else
			z <= 0;
	end

endmodule
