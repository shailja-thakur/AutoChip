module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // reset to state A
		else
			case (state)
				2'b00: // state A
					if (in)
						state <= 2'b01; // next state B if in=1
					else
						state <= 2'b00; // next state A if in=0
				2'b01: // state B
					if (in)
						state <= 2'b01; // next state B if in=1
					else
						state <= 2'b10; // next state C if in=0
				2'b10: // state C
					if (in)
						state <= 2'b11; // next state D if in=1
					else
						state <= 2'b00; // next state A if in=0
				2'b11: // state D
					if (in)
						state <= 2'b01; // next state B if in=1
					else
						state <= 2'b10; // next state C if in=0
			endcase
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // set out to 1 when state is D
	
endmodule
