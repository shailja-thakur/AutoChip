module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// State definitions
	parameter A = 2'b00;
	parameter B = 2'b01;

	// State register
	reg [1:0] state;

	// Next-state logic
	always @(posedge clk or negedge areset) begin
		if (!areset)
			state <= A;
		else begin
			case (state)
				A: state <= x ? B : A;
				B: state <= B;
			endcase
		end
	end

	// Output logic
	assign z = (state == A && x) || (state == B && !x);

endmodule
