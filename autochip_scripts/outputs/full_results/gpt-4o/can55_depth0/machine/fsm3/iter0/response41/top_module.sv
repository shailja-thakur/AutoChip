module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State Encoding
	reg [1:0] state, next_state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// Combinational logic for next state
	always @(*) begin
		case (state)
			A: next_state = (in) ? B : A;
			B: next_state = (in) ? B : C;
			C: next_state = (in) ? D : A;
			D: next_state = (in) ? B : C;
			default: next_state = A;
		endcase
	end

	// Synchronous state register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == D);

endmodule
