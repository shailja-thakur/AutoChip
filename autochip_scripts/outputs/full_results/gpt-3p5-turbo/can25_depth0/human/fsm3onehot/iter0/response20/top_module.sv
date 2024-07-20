module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

	always @(*) begin
		case (state)
			4'b0001: // A
				if (in)
					next_state = 4'b0010; // B
				else
					next_state = 4'b0001; // A
			4'b0010: // B
				if (in)
					next_state = 4'b0010; // B
				else
					next_state = 4'b0100; // C
			4'b0100: // C
				if (in)
					next_state = 4'b0001; // A
				else
					next_state = 4'b1000; // D
			4'b1000: // D
				if (in)
					next_state = 4'b0100; // C
				else
					next_state = 4'b0010; // B
		endcase
	end

	always @(state) begin
		case (state)
			4'b0001: // A
				out = 1'b0;
			default:
				out = 1'b1;
		endcase
	end

endmodule
