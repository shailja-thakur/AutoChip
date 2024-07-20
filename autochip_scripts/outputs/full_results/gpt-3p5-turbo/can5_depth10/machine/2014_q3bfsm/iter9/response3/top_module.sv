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
			state <= 3'b001; // state A
		else
		begin
			case(state)
				3'b001: // state A
					if(x)
						state <= 3'b010; // state B
					else
						state <= 3'b001; // state A
				3'b010: // state B
					if(x)
						state <= 3'b110; // state E
					else
						state <= 3'b010; // state B
				3'b110: // state E
					if(x)
						state <= 3'b110; // state E
					else
						state <= 3'b101; // state D
				3'b101: // state D
					if(x)
						state <= 3'b100; // state C
					else
						state <= 3'b110; // state E
				3'b100: // state C
					if(x)
						state <= 3'b010; // state B
					else
						state <= 3'b101; // state D
				default:
					state <= 3'b001; // state A
			endcase
		end
	end
	
	always @(state)
	begin
		case(state)
			3'b110, 3'b101: // states E, D
				z <= 1'b1; // output high
			default:
				z <= 1'b0; // output low
		endcase
	end
	
endmodule
