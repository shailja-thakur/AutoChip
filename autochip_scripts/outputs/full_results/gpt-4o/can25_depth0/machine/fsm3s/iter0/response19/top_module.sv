module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	typedef enum reg [1:0] {A=2'b00, B=2'b01, C=2'b10, D=2'b11} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			A: next_state = in ? B : A;
			B: next_state = in ? B : C;
			C: next_state = in ? D : A;
			D: next_state = in ? B : C;
			default: next_state = A;
		endcase
	end

	// Sequential block
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == D);
	end

endmodule
