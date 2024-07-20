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
		// Default to avoid inferred latches and set output
		next_state = 4'b0000;
		out = 1'b0;
		
		case (state)
			A: begin
				next_state = in ? B : A;
				out = 1'b0;
			end
			B: begin
				next_state = in ? B : C;
				out = 1'b0;
			end
			C: begin
				next_state = in ? D : A;
				out = 1'b0;
			end
			D: begin
				next_state = in ? B : C;
				out = 1'b1;
			end
			default: begin
				next_state = 4'b0000;  // catch invalid states
				out = 1'b0;
			end
		endcase
	end

endmodule
