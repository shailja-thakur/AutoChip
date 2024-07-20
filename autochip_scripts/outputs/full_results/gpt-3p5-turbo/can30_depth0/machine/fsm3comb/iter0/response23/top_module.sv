module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always_comb begin
	case (state)
		2'b00: begin // State A
			if (in)
				next_state = 2'b01; // Transition to state B
			else
				next_state = 2'b00; // Remain in state A
		end
		
		2'b01: begin // State B
			if (in)
				next_state = 2'b01; // Remain in state B
			else
				next_state = 2'b10; // Transition to state C
		end
		
		2'b10: begin // State C
			if (in)
				next_state = 2'b11; // Transition to state D
			else
				next_state = 2'b00; // Transition to state A
		end
		
		2'b11: begin // State D
			if (in)
				next_state = 2'b01; // Transition to state B
			else
				next_state = 2'b10; // Transition to state C
		end
	endcase
end

assign out = (state == 2'b11); // Output is high when in state D

endmodule
