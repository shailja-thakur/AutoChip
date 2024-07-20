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
					begin
						if (in)
							state <= 2'b01; // state B
						else
							state <= 2'b00; // state A
					end
					
				2'b01: // state B
					begin
						if (in)
							state <= 2'b01; // state B
						else
							state <= 2'b10; // state C
					end
					
				2'b10: // state C
					begin
						if (in)
							state <= 2'b11; // state D
						else
							state <= 2'b00; // state A
					end
					
				2'b11: // state D
					begin
						if (in)
							state <= 2'b01; // state B
						else
							state <= 2'b10; // state C
					end
			endcase
		end
	end
	
	assign out = (state == 2'b11); // Output is 1 when state is D
	
endmodule
