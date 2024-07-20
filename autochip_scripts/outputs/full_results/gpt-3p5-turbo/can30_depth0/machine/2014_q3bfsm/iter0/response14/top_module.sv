module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state; // internal state represented by 3 bits

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000; // reset state to A
	else begin
		case(state)
			3'b000: // state A
				if (x)
					state <= 3'b001; // next state B
				else
					state <= 3'b000; // next state A
			3'b001: // state B
				if (x)
					state <= 3'b100; // next state E
				else
					state <= 3'b001; // next state B
			3'b010: // state C
				if (x)
					state <= 3'b001; // next state B
				else
					state <= 3'b010; // next state C
			3'b011: // state D
				if (x)
					state <= 3'b010; // next state C
				else
					state <= 3'b001; // next state B
			3'b100: // state E
				if (x)
					state <= 3'b100; // next state E
				else
					state <= 3'b011; // next state D
			default: state <= 3'b000; // default to state A
		endcase
	end
end

always @(*) begin
	case (state)
		3'b011, 3'b100: z = 1; // output is high for states D and E
		default: z = 0; // output is low for all other states
	endcase
end

endmodule
