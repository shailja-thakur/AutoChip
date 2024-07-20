module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	parameter A = 1'b0;
	parameter B = 1'b1;

	reg state;

	always @(posedge clk) begin
		if (areset)
			state <= A;
		else begin
			case (state)
				A: begin
					if (x)
						state <= B;
				end
				B: begin
					state <= B;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (areset)
			z <= 0;
		else begin
			case (state)
				A: begin
					if (x)
						z <= 1;
					else
						z <= 0;
				end
				B: begin
					if (x)
						z <= 0;
				end
			endcase
		end
	end
	endmodule
