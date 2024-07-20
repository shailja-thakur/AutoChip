module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always_comb begin
		case (state)
			2'b00: // Current state is A
				begin
					if (in)
						next_state = 2'b01; // Next state is B
					else
						next_state = 2'b00; // Next state remains A
				end
			2'b01: // Current state is B
				begin
					if (in)
						next_state = 2'b01; // Next state remains B
					else
						next_state = 2'b10; // Next state is C
				end
			2'b10: // Current state is C
				begin
					if (in)
						next_state = 2'b11; // Next state is D
					else
						next_state = 2'b00; // Next state is A
				end
			2'b11: // Current state is D
				begin
					if (in)
						next_state = 2'b01; // Next state is B
					else
						next_state = 2'b10; // Next state is C
				end
		endcase
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output is high when state is D

endmodule
