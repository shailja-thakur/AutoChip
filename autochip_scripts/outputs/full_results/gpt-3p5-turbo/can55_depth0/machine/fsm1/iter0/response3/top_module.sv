module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	wire prevState_A, prevState_B;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b01;  // Set state to B on reset
		else begin
			case (state)
				2'b00: 
					if (in)
						state <= 2'b00;  // Stay in state A if input is high
					else
						state <= 2'b01;  // Transition to state B if input is low
				2'b01:
					if (in)
						state <= 2'b01;  // Stay in state B if input is high
					else
						state <= 2'b00;  // Transition to state A if input is low
			endcase
		end
	end
	
	assign out = (state == 2'b01);

endmodule
