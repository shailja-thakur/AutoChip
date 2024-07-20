module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	reg [1:0] state, next_state;
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// State transition
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Next state logic
	always @ (*) begin
		case (state)
			A: next_state = (in) ? B : A;
			B: next_state = (in) ? B : C;
			C: next_state = (in) ? D : A;
			D: next_state = (in) ? B : C;
			default: next_state = A;   // Default state is A
		endcase
	end
	
	// Output logic
	always @ (*) begin
		case (state)
			A: out = 0;
			B: out = 0;
			C: out = 0;
			D: out = 1;
			default: out = 0;
		endcase
	end

endmodule
