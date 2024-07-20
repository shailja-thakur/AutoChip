module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	parameter A = 1'b0, B = 1'b1;
	reg state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else begin
			case (state)
				A: if (x == 1) state <= B;
				B: state <= B;
			endcase
		end
	end

	always @(*) begin
		case (state)
			A: z = (x == 1) ? 1 : 0;
			B: z = (x == 0) ? 1 : 0;
		endcase
	end

endmodule
