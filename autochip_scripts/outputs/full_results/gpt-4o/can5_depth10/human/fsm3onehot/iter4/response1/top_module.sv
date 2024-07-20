module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);
	// State encoding
	localparam A = 4'b0001;
	localparam B = 4'b0010;
	localparam C = 4'b0100;
	localparam D = 4'b1000;

	// State transition logic
	always @(*) begin
		// Default assignment for next_state to handle invalid state inputs
		next_state = 4'b0000; 
		case (state)
			A: next_state = (in) ? B : A;
			B: next_state = (in) ? B : C;
			C: next_state = (in) ? D : A;
			D: next_state = (in) ? B : C;
			default: next_state = A;  // Default to state A if state is invalid
		endcase
	end

	// Output logic
	always @(*) begin
		out = (state == D) ? 1 : 0;
	end
	
endmodule
