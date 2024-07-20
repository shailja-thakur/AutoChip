module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state, next_state;
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Asynchronous reset sets state to A
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case(state)
			A: next_state = (in) ? B : A;
			B: next_state = (in) ? B : C;
			C: next_state = (in) ? D : A;
			D: next_state = (in) ? B : C;
			default: next_state = A;
		endcase
	end

	// Output logic
	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
