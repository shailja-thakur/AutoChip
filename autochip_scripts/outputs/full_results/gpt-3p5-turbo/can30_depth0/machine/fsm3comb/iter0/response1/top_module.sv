module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always_comb begin
	next_state = state;
	case (state)
		2'b00: begin // State is A
			if (in)
				next_state = 2'b01; // Next state is B
		end
		2'b01: begin // State is B
			if (!in)
				next_state = 2'b10; // Next state is C
		end
		2'b10: begin // State is C
			if (in)
				next_state = 2'b11; // Next state is D
		end
		2'b11: begin // State is D
			if (!in)
				next_state = 2'b01; // Next state is B
		end
	endcase
end

assign out = (state == 2'b11); // Set out to high only when state is D

endmodule
