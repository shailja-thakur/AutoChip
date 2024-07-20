module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	// State transition logic
	always @(*) begin
		case (state)
			2'b00: begin // State A
				if (in)
					next_state = 2'b01; // Next state B
				else
					next_state = 2'b00; // Next state A
			end
			
			2'b01: begin // State B
				if (in)
					next_state = 2'b01; // Next state B
				else
					next_state = 2'b10; // Next state C
			end
			
			2'b10: begin // State C
				if (in)
					next_state = 2'b00; // Next state A
				else
					next_state = 2'b11; // Next state D
			end
			
			2'b11: begin // State D
				if (in)
					next_state = 2'b10; // Next state C
				else
					next_state = 2'b01; // Next state B
			end
		endcase
	end

	// Output logic
	always @(state) begin
		case (state)
			2'b00: out = 1'b0;
			2'b01: out = 1'b0;
			2'b10: out = 1'b0;
			2'b11: out = 1'b1;
		endcase
	end

endmodule
