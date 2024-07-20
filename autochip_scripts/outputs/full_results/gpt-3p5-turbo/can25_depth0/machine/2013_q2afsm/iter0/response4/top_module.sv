module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

	reg [1:0] state, next_state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 2'b00;  // set initial state to A
		end else begin
			state <= next_state;  // update state with next_state
		end
	end

	always @* begin
		case (state)
			2'b00: begin  // state A
				if (r[2] == 1'b1)
					next_state = 2'b10;  // next state is C
				else if (r[1] == 1'b1)
					next_state = 2'b01;  // next state is B
				else if (r[0] == 1'b1)
					next_state = 2'b11;  // next state is D
				else
					next_state = 2'b00;  // next state is A
			end
			2'b01: begin  // state B
				if (r[1] == 1'b1)
					next_state = 2'b01;  // next state is B
				else
					next_state = 2'b00;  // next state is A
			end
			2'b10: begin  // state C
				if (r[2] == 1'b1)
					next_state = 2'b10;  // next state is C
				else
					next_state = 2'b00;  // next state is A
			end
			2'b11: begin  // state D
				if (r[0] == 1'b1)
					next_state = 2'b11;  // next state is D
				else
					next_state = 2'b00;  // next state is A
			end
		endcase
	end

	always @(state) begin
		case (state)
			2'b01: g[2] = 1'b1;  // state B, g[2] is high
			2'b10: g[1] = 1'b1;  // state C, g[1] is high
			2'b11: g[0] = 1'b1;  // state D, g[0] is high
			default: g = 3'b000;  // all other states, g is low
		endcase
	end

endmodule
