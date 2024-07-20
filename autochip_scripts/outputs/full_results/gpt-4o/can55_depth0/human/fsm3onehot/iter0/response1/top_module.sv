module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// Define state encoding
	localparam A = 4'b0001;
	localparam B = 4'b0010;
	localparam C = 4'b0100;
	localparam D = 4'b1000;

	always @(*) begin
		// Default next_state
		next_state = 4'b0000;

		// State Transition Logic
		case (state)
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
			
			default: next_state = A;
		endcase
	end

	// Output Logic
	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
