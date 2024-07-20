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
					next_state = 2'b01;
				else
					next_state = 2'b00;
			2'b01:
				if (in)
					next_state = 2'b01;
				else
					next_state = 2'b10;
			2'b10:
				if (in)
					next_state = 2'b11;
				else
					next_state = 2'b00;
			2'b11:
				if (in)
					next_state = 2'b01;
				else
					next_state = 2'b10;
		endcase
	end

	assign out = (state == 2'b11);

endmodule
