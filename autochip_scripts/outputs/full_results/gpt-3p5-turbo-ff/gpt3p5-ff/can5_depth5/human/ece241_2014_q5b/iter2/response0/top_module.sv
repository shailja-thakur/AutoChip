module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	
	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else
			case(state)
				2'b00: state <= x ? 2'b01 : 2'b00;
				2'b01: state <= x ? 2'b01 : 2'b00;
				default: state <= state;
			endcase
	end
	
	always @(state) begin
		case(state)
			2'b00: z <= 1'b0;
			2'b01: z <= 1'b1;
			default: z <= z;
		endcase
	end
	
endmodule
