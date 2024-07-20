module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);
	reg [1:0] current_state;

	always_comb begin
		case(state)
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

	always @(posedge clk)
		current_state <= state;
	
	assign out = (current_state == 2'b11);

endmodule
