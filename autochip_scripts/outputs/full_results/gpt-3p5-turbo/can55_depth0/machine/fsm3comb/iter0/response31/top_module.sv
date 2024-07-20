module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	// define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always_comb begin
		// state transition logic
		case(state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
		endcase
	end

	// output logic
	always @(posedge clk) begin
		if (state == D)
			out = 1'b1;
		else
			out = 1'b0;
	end

endmodule
