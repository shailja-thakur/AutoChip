module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(state or w) begin
		case (state)
			2'b00: begin // state A
				if (s == 1)
					next_state = 2'b01;
				else
					next_state = 2'b00;
			end
			2'b01: begin // state B
				if (w == 1)
					next_state = 2'b11;
				else
					next_state = 2'b10;
			end
			2'b10: begin // state C
				if (w == 1)
					next_state = 2'b11;
				else
					next_state = 2'b00;
			end
			2'b11: begin // state D
				next_state = 2'b00;
			end
			default: next_state = 2'b00;
		endcase
	end

	always @(posedge clk) begin
		if (state == 2'b11) begin // state D
			z <= (w & (state[0] ^ state[1]));
		end
		else begin
			z <= 0;
		end
	end
endmodule
