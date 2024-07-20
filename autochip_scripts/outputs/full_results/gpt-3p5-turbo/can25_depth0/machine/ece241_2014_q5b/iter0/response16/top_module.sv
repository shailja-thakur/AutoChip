module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	parameter A = 1;
	parameter B = 2;

	reg [1:0] state;
	reg z;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (x) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				B: begin
					state <= B;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == A && x) begin
			z <= 1;
		end else if (state == B && !x) begin
			z <= 1;
		end else begin
			z <= 0;
		end
	end

endmodule
