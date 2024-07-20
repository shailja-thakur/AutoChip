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
		// Default next_state and output
		next_state = 4'b0000;
		out = 0;
		
		case (state)
			A: begin
				next_state = (in) ? B : A;
				out = 0;
			end
			B: begin
				next_state = (in) ? B : C;
				out = 0;
			end
			C: begin
				next_state = (in) ? D : A;
				out = 0;
			end
			D: begin
				next_state = (in) ? B : C;
				out = 1;
			end
			default: begin
				// Handle invalid state by resetting to a known state, e.g., state A
				next_state = A;
				out = 0;
			end
		endcase
	end

endmodule
