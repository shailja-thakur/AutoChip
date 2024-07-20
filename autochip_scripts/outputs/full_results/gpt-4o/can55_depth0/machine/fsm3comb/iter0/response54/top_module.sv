module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

	// State Encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

	// Always block to determine next state
	always @(*) begin
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

			default: next_state = A; // Default to state A
		endcase 
	end

	// Assign output 'out' based on state
	always @(*) begin
		if (state == D)
			out = 1'b1;
		else
			out = 1'b0;
		end
endmodule
