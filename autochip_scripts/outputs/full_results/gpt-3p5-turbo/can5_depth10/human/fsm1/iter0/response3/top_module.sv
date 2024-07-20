module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State variables
	reg [1:0] state;
	
	// Next state logic
	always @ (posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b01; // state B
		else
		begin
			case (state)
				2'b01: // state B
					if (in)
						state <= 2'b01; // next state B
					else
						state <= 2'b00; // next state A
				2'b00: // state A
					if (in)
						state <= 2'b00; // next state A
					else
						state <= 2'b01; // next state B
			endcase
		end
	end
	
	// Output logic
	assign out = state[0];
	
endmodule
