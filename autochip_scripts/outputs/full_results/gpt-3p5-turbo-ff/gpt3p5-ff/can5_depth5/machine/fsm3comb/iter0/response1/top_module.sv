module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

	always_comb begin
		case (state)
			2'b00:
				if (in)
					next_state = 2'b01; // State A -> B transition
				else
					next_state = 2'b00; // No state change
			2'b01:
				if (in)
					next_state = 2'b01; // State B -> B transition
				else
					next_state = 2'b10; // State B -> C transition
			2'b10:
				if (in)
					next_state = 2'b11; // State C -> D transition
				else
					next_state = 2'b00; // State C -> A transition
			2'b11:
				if (in)
					next_state = 2'b01; // State D -> B transition
				else
					next_state = 2'b10; // State D -> C transition
		endcase
	end

	assign out = (state == 2'b11); // Output is high when state is D

endmodule
