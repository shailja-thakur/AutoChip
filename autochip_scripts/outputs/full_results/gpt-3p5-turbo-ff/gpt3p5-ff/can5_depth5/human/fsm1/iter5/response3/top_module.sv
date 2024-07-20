module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state;
	always @(posedge clk or negedge areset)
		if (areset) 
			state <= 2'b01; // B
		else
			case(state)
				2'b00: if (in) state <= 2'b01; else state <= 2'b00;
				2'b01: if (in) state <= 2'b01; else state <= 2'b00;
				2'b10: if (in) state <= 2'b00; else state <= 2'b10;
				2'b11: if (in) state <= 2'b00; else state <= 2'b10;
			endcase
			
	always @(state)
		case(state)
			2'b00: out <= 1'b0;
			default: out <= 1'b1;
		endcase

endmodule
