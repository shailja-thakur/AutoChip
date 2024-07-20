module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	reg [1:0] next_state;

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;

	always @(posedge clk or posedge areset)
		begin
			if (areset)
				state <= S0;
			else
				state <= next_state;
		end

	always @(state, x)
		begin
			case (state)
				S0:
					begin
						if (areset)
							next_state <= S0;
						else if (x == 1'b0)
							next_state <= S0;
						else
							next_state <= S1;
					end
				S1:
					begin
						if (areset)
							next_state <= S0;
						else if (x == 1'b0)
							next_state <= S0;
						else
							next_state <= S1;
					end
				default:
					next_state <= S0;
			endcase
		end

	always @(state)
		begin
			case (state)
				S0: z <= ~x;
				S1: z <= ~x + 1'b1;
				default: z <= 0;
			endcase
		end

endmodule
