module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	reg [2:0] next_state;
	
	always @(posedge clk or posedge reset)
	begin
		if(reset)
			state <= 3'b000; // state A
		else
			state <= next_state;
	end
	
	always @(*)
	begin
		case(state)
			3'b000: // state A
				if(x)
					next_state = 3'b001; // state B
				else
					next_state = 3'b000; // state A
			3'b001: // state B
				if(x)
					next_state = 3'b100; // state E
				else
					next_state = 3'b001; // state B
			3'b100: // state E
				if(x)
					next_state = 3'b100; // state E
				else
					next_state = 3'b011; // state D
			3'b011: // state D
				if(x)
					next_state = 3'b010; // state C
				else
					next_state = 3'b100; // state E
			3'b010: // state C
				if(x)
					next_state = 3'b001; // state B
				else
					next_state = 3'b011; // state D
			default:
				next_state = 3'b000; // state A
		endcase
	end
	
	always @(state)
	begin
		case(state)
			3'b011, 3'b100: // states D, E
				z <= 1'b1; // output high
			default:
				z <= 1'b0; // output low
		endcase
	end
	
endmodule
