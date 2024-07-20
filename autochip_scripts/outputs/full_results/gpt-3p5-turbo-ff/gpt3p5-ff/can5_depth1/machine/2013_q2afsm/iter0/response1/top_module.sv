module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge resetn)
begin
	if (!resetn)
		state <= 3'b000; // set to state A
	else
		state <= next_state; // update with next state
end

always @*
begin
	case (state)
		3'b000: // state A
			if (r[1]) // if r[1] is high, go to B
				next_state = 3'b001;
			else if (r[2]) // if r[2] is high, go to C
				next_state = 3'b010;
			else if (r[3]) // if r[3] is high, go to D
				next_state = 3'b011;
			else // if none of the bits are high, go to A
				next_state = 3'b000;
		3'b001: // state B
			if (r[1]) // if r[1] is high, stay in B
				next_state = 3'b001;
			else // otherwise, go to A
				next_state = 3'b000;
		3'b010: // state C
			if (r[2]) // if r[2] is high, stay in C
				next_state = 3'b010;
			else // otherwise, go to A
				next_state = 3'b000;
		3'b011: // state D
			if (r[3]) // if r[3] is high, stay in D
				next_state = 3'b011;
			else // otherwise, go to A
				next_state = 3'b000;
		default: next_state = 3'b000; // default to state A
	endcase
end

assign g[1] = (state == 3'b001) ? 1'b1 : 1'b0; // set g[1] high if current state is B
assign g[2] = (state == 3'b010) ? 1'b1 : 1'b0; // set g[2] high if current state is C
assign g[3] = (state == 3'b011) ? 1'b1 : 1'b0; // set g[3] high if current state is D
endmodule
