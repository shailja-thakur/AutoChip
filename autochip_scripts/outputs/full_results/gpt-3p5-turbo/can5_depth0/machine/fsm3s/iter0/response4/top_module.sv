module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 2'b00; // initial state A
		else 
		begin
			case (state)
				2'b00: // state A
					if (in)
						state <= 2'b01; // state B
					else
						state <= 2'b00; // state A
					
				2'b01: // state B
					if (in)
						state <= 2'b01; // state B
					else
						state <= 2'b10; // state C
					
				2'b10: // state C
					if (in)
						state <= 2'b11; // state D
					else
						state <= 2'b00; // state A
					
				2'b11: // state D
					if (in)
						state <= 2'b01; // state B
					else
						state <= 2'b10; // state C
			endcase
		end
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;
	
endmodule
