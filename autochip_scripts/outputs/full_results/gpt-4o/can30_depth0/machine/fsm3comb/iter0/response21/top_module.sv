module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

// State encoding
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

// State transition logic
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
		default: next_state = A; // Default state
	endcase
end

// Output logic
assign out = (state == D);

endmodule
