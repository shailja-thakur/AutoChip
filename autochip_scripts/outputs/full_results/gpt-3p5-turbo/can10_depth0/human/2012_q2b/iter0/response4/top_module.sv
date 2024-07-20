module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg [5:0] next_state;

always @* begin
	case(y)
		6'b000001: next_state = w ? 6'b000010 : 6'b000001;
		6'b000010: next_state = w ? 6'b000100 : 6'b000011;
		6'b000100: next_state = w ? 6'b001000 : 6'b001001;
		6'b001000: next_state = w ? 6'b010000 : 6'b010001;
		6'b010000: next_state = w ? 6'b100000 : 6'b010011;
		6'b100000: next_state = w ? 6'b000100 : 6'b100010;
		default: next_state = 6'b000000;
	endcase
end

assign Y1 = next_state[1];
assign Y3 = next_state[3];

endmodule
