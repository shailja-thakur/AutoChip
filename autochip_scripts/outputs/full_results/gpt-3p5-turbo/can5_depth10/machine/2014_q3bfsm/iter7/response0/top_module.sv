module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset)
	begin
		if(reset)
			state <= 3'b000; // state A
		else
		begin
			case(state)
				3'b000: // state A
					if(x)
						state <= 3'b001; // state B
					else
						state <= 3'b000; // state A
				3'b001: // state B
					if(x)
						state <= 3'b100; // state E
					else
						state <= 3'b001; // state B
				3'b100: // state E
					if(x)
						state <= 3'b100; // state E
					else
						state <= 3'b010; // state C
				3'b010: // state C
					if(x)
						state <= 3'b001; // state B
					else
						state <= 3'b011; // state D
				3'b011: // state D
					if(x)
						state <= 3'b100; // state E
					else
						state <= 3'b011; // state D
				default:
					state <= 3'b000; // state A
			endcase
		end
	end
	
	always @(state)
	begin
		case(state)
			3'b100, 3'b011: // states E, D
				z <= 1'b1; // output high
			default:
				z <= 1'b0; // output low
		endcase
	end
	
endmodule
