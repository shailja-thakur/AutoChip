module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

	always @(*) begin
		// Default values
		next_state = state;
		out = 0;

		case (state)
			2'b00: begin // State A
				next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A->A if in=0, else A->B
				out = 0;
			end
			2'b01: begin // State B
				next_state = (in == 1'b0) ? 2'b10 : 2'b01; // B->C if in=0, else B->B
				out = 0;
			end
			2'b10: begin // State C
				next_state = (in == 1'b0) ? 2'b00 : 2'b11; // C->A if in=0, else C->D
				out = 0;
			end
			2'b11: begin // State D
				next_state = (in == 1'b0) ? 2'b10 : 2'b01; // D->C if in=0, else D->B
				out = 1;
			end
		endcase
	end
endmodule
