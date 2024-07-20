module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always @ (in, state) begin
		case (state)
			2'b00: begin // State A
				next_state = (in == 1'b0) ? 2'b00 : 2'b01; // Next State: A, B
				out = 1'b0;
			end
			2'b01: begin // State B
				next_state = (in == 1'b0) ? 2'b10 : 2'b01; // Next State: C, B
				out = 1'b0;
			end
			2'b10: begin // State C
				next_state = (in == 1'b0) ? 2'b00 : 2'b11; // Next State: A, D
				out = 1'b0;
			end
			2'b11: begin // State D
				next_state = (in == 1'b0) ? 2'b10 : 2'b01; // Next State: C, B
				out = 1'b1;
			end
		endcase
	end

endmodule
