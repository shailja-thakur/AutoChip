module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	parameter A = 1'b0;
	parameter B = 1'b1;

	reg [1:0] state;
	wire rising_edge;

	assign rising_edge = x & ~areset;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			case (state)
				A: state <= (x == 1'b1) ? B : A;
				B: state <= B;
			endcase
	end

	assign z = (state == A & x) | (state == B & ~rising_edge);

endmodule
