module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// State encoding
	reg state, next_state;
	localparam A = 1'b0, B = 1'b1;

	// State transition logic (combinational always block)
	always @(*) begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A;
		endcase
	end

	// State register (clocked always block)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B);

endmodule
