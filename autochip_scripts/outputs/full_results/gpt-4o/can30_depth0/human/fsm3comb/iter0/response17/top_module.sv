module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

	// State encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

	always @(*) begin
		case (state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out = 0;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out = 0;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out = 1;
			end
			default: begin
				next_state = A; // Default case to avoid latches
				out = 0;
			end
		endcase
	end
endmodule
