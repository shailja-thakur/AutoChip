module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [1:0] state; // state register
	reg [1:0] next; // next state register

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= 2'b00; // reset to state A
		else
			state <= next; // set state to next state
	end

	always @(state or r) begin
		case(state)
			2'b00: begin // state A
				if (r[1]) next <= 2'b01; // next state is B if r[1] is high
				else if (r[2]) next <= 2'b10; // next state is C if r[2] is high
				else if (r[3]) next <= 2'b11; // next state is D if r[3] is high
				else next <= 2'b00; // next state is A if none of the bits of r is high
			end
			2'b01: begin // state B
				if (r[1]) next <= 2'b01; // next state is B if r[1] is high
				else next <= 2'b00; // next state is A if r[1] is low
			end
			2'b10: begin // state C
				if (r[2]) next <= 2'b10; // next state is C if r[2] is high
				else next <= 2'b00; // next state is A if r[2] is low
			end
			2'b11: begin // state D
				if (r[3]) next <= 2'b11; // next state is D if r[3] is high
				else next <= 2'b00; // next state is A if r[3] is low
			end
		endcase
	end

	assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // set g[1] high if state is B
	assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // set g[2] high if state is C
	assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0; // set g[3] high if state is D

endmodule
