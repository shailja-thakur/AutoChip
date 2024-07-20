module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

	// State Encoding
	parameter A = 4'b0001;
	parameter B = 4'b0010;
	parameter C = 4'b0100;
	parameter D = 4'b1000;

	// State Transition Logic
	always @(*) begin
		case (state)
			A: begin
				if (in) next_state = B;
				else next_state = A;
			end
			B: begin
				if (in) next_state = B;
				else next_state = C;
			end
			C: begin
				if (in) next_state = D;
				else next_state = A;
			end
			D: begin
				if (in) next_state = B;
				else next_state = C;
			end
			default: next_state = 4'b0000; // Default case to handle error state
		endcase
	end

	// Output Logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
			default: out = 1'b0; // Default case to handle error state
		endcase
	end

endmodule
