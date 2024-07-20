module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or negedge areset)
		if (areset) 
			state <= 2'b10; // B
		else
			case(state)
				2'b00: if (in) state <= 2'b01; else state <= 2'b00;
				2'b01: if (in) state <= 2'b00; else state <= 2'b01;
				2'b10: if (in) state <= 2'b11; else state <= 2'b10;
				2'b11: if (in) state <= 2'b10; else state <= 2'b11;
			endcase
			
	assign out = (state == 2'b00);

endmodule
