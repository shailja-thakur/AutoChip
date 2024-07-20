module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

// State Encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Combinational logic for next_state and output
always @(*) begin
	case (state)
		A: begin
			if (in == 0)
				next_state = A;
			else
				next_state = B;
		end
		B: begin
			if (in == 0)
				next_state = C;
			else
				next_state = B;
		end
		C: begin
			if (in == 0)
				next_state = A;
			else
				next_state = D;
		end
		D: begin
			if (in == 0)
				next_state = C;
			else
				next_state = B;
		end
		default: next_state = A; // Default state to avoid latches
	endcase
end

// Output logic
assign out = (state == D) ? 1 : 0;

endmodule
