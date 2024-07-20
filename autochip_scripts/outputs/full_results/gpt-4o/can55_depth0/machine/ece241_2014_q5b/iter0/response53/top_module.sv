module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg state;
	parameter A = 1'b0, B = 1'b1;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			case (state)
				A: if (x) state <= B;
				   else state <= A;
				B: state <= B;
			endcase
		end
	end

	assign z = (state == A && x == 1) || (state == B && x == 0);

endmodule
