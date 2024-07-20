module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// State transition logic
	always @(*) begin
		case (state)
			4'b0001: begin // A
				if (in)
					next_state = 4'b0010; // B
				else
					next_state = 4'b0001; // A
			end
			4'b0010: begin // B
				if (in)
					next_state = 4'b0010; // B
				else
					next_state = 4'b0100; // C
			end
			4'b0100: begin // C
				if (in)
					next_state = 4'b1000; // D
				else
					next_state = 4'b0001; // A
			end
			4'b1000: begin // D
				if (in)
					next_state = 4'b0010; // B
				else
					next_state = 4'b0100; // C
			end
			default: next_state = 4'b0001; // default to A
		endcase
	end

	// Output logic
	assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // output is 1 in state D, 0 otherwise

endmodule
