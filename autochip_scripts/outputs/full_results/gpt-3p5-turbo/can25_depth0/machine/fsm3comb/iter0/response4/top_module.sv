module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always_comb begin
		case (state)
			2'b00: begin // Current state is A
				if (in == 1'b1) // If 'in' signal is high
					next_state = 2'b01; // Next state is B
				else
					next_state = 2'b00; // Next state remains A
			end
			
			2'b01: begin // Current state is B
				if (in == 1'b1) // If 'in' signal is high
					next_state = 2'b01; // Next state remains B
				else
					next_state = 2'b10; // Next state is C
			end
			
			2'b10: begin // Current state is C
				if (in == 1'b1) // If 'in' signal is high
					next_state = 2'b11; // Next state is D
				else
					next_state = 2'b00; // Next state is A
			end
			
			2'b11: begin // Current state is D
				if (in == 1'b1) // If 'in' signal is high
					next_state = 2'b01; // Next state is B
				else
					next_state = 2'b10; // Next state is C
			end
		endcase
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // 'out' is high when state is D

endmodule
