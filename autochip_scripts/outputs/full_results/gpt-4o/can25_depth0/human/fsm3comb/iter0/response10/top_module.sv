module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

	// State encoding
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always @(*) begin
		// Default output
		out = 1'b0;
		
		case (state)
			A: begin
				if (in == 1'b0)
					next_state = A;
				else
					next_state = B;
				out = 1'b0;
			end
			B: begin
				if (in == 1'b0)
					next_state = C;
				else
					next_state = B;
				out = 1'b0;
			end
			C: begin
				if (in == 1'b0)
					next_state = A;
				else
					next_state = D;
				out = 1'b0;
			end
			D: begin
				if (in == 1'b0)
					next_state = C;
				else
					next_state = B;
				out = 1'b1;
			end
			default: begin
				next_state = A; // Default state
				out = 1'b0; // Default output
			end
		endcase
	end
endmodule
