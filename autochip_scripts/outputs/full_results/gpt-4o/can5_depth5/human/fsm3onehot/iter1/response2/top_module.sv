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

	// State transition logic and output logic
	always @(*) begin
		// Default values to handle invalid states
		next_state = A;
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
			// Default state is A for any invalid state
			default: begin
				next_state = A;
				out = 1'b0;
			end
		endcase
	end

endmodule
