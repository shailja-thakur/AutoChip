module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [2:0] state;
	reg [2:0] next_state;
	reg z;

	parameter S0 = 3'b000;
	parameter S1 = 3'b001;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			z <= 1'b0;
		end else begin
			state <= next_state;
			z <= x ^ 3'b111;
		end
	end

	always @* begin
		case (state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x == 1'b0)
					next_state = S1;
				else
					next_state = S0;
			end
			default: next_state = S0;
		endcase
	end

endmodule
