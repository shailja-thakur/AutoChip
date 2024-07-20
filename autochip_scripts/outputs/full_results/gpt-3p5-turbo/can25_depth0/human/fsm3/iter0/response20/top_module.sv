module top_module (
    input clk,
    input in,
    input areset,
    output out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b0;
		else
			state <= next_state;
	end

	always @(state, in) begin
		case (state)
			2'b00: begin // state A
				if (in)
					next_state = 2'b01; // next state B
				else
					next_state = 2'b00; // next state A

				out = 1'b0;
			end
			2'b01: begin // state B
				if (in)
					next_state = 2'b01; // next state B
				else
					next_state = 2'b10; // next state C

				out = 1'b0;
			end
			2'b10: begin // state C
				if (in)
					next_state = 2'b11; // next state D
				else
					next_state = 2'b00; // next state A

				out = 1'b0;
			end
			2'b11: begin // state D
				if (in)
					next_state = 2'b10; // next state C
				else
					next_state = 2'b01; // next state B

				out = 1'b1;
			end
			default: begin
				next_state = 2'b00; // default to state A
				out = 1'b0;
			end
		endcase
	end
endmodule
