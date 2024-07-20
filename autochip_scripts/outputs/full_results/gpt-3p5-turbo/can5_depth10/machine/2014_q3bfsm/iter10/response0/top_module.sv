module top_module (
	input wire clk,
	input wire reset,
	input wire x,
	output wire z
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
						state <= 3'b110; // state E
					else
						state <= 3'b001; // state B
				3'b110: // state E
					if(x)
						state <= 3'b110; // state E
					else
						state <= 3'b101; // state D
				3'b101: // state D
					if(x)
						state <= 3'b100; // state C
					else
						state <= 3'b010; // state B
				3'b100: // state C
					if(x)
						state <= 3'b010; // state B
					else
						state <= 3'b101; // state D
				default:
					state <= 3'b000; // state A
			endcase
		end
	end
	
	assign z = (state == 3'b110 || state == 3'b101) ? 1'b1 : 1'b0;
	
endmodule
