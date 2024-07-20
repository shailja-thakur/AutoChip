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

	// Check if the state is valid one-hot
	wire valid_state = (state == A) || (state == B) || (state == C) || (state == D);

	// State transition logic
	always @(*) begin
		if (valid_state) begin
			case (state)
				A: next_state = (in) ? B : A;
				B: next_state = (in) ? B : C;
				C: next_state = (in) ? D : A;
				D: next_state = (in) ? B : C;
				default: next_state = 4'b0000; // Should never reach here, handled by valid_state check
			endcase
		end else begin
			next_state = 4'b0000; // Force to an invalid state
		end
	end

	// Output logic
	always @(*) begin
		if (valid_state) begin
			out = (state == D) ? 1 : 0;
		end else begin
			out = 0; // Default output for invalid states
		end
	end
	
endmodule
