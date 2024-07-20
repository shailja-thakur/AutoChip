module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);
	// State encoding
	parameter A = 4'b0001;
	parameter B = 4'b0010;
	parameter C = 4'b0100;
	parameter D = 4'b1000;

	// State transition logic
	always @(*) begin
		// Set default output
		next_state = 4'b0000; // Default to handle invalid states

		case (state)
			A: next_state = (in) ? B : A;
			B: next_state = (in) ? B : C;
			C: next_state = (in) ? D : A;
			D: next_state = (in) ? B : C;
		endcase
	end

	// Output logic
	always @(*) begin
		if (state == D)
			out = 1;
		else
			out = 0;
	end
	
endmodule
