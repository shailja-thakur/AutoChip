module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

	always @(*) begin
		case (state)
			2'b00: begin // State A
				out = 0;
				if (in == 0)
					next_state = 2'b00; // Stay in A
				else
					next_state = 2'b01; // Go to B
			end
			2'b01: begin // State B
				out = 0;
				if (in == 0)
					next_state = 2'b10; // Go to C
				else
					next_state = 2'b01; // Stay in B
			end
			2'b10: begin // State C
				out = 0;
				if (in == 0)
					next_state = 2'b00; // Go to A
				else
					next_state = 2'b11; // Go to D
			end
			2'b11: begin // State D
				out = 1;
				if (in == 0)
					next_state = 2'b10; // Go to C
				else
					next_state = 2'b01; // Go to B
			end
			default: begin
				next_state = 2'b00; // Default state
				out = 0;
			end
		endcase
	end

endmodule
