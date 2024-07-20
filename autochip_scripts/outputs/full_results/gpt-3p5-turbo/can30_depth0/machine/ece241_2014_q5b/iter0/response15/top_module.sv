module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg state;

	parameter A = 1;
	parameter B = 2;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end
		else begin
			case (state)
				A: begin
					state <= (x == 1) ? B : A;
				end
				B: begin
					state <= B;
				end
			endcase
		end
	end

	assign z = (state == A && x == 1) || (state == B && x == 0);

endmodule
