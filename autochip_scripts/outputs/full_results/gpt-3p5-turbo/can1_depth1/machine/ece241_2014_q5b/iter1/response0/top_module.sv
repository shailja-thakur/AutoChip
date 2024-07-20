module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	parameter A = 1;
	parameter B = 2;
	reg [1:0] state;

	always @(posedge clk or negedge areset) begin
		if (!areset) begin
			state <= A;
		end else begin
			case(state)
				A: if (x == 1) state <= B; else state <= A;
				B: state <= B;
			endcase
		end
	end

	assign z = (state == A && x == 1) || (state == B && x == 0);

endmodule
