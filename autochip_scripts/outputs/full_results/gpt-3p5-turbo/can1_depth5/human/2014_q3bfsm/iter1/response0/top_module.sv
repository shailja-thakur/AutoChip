module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] y;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			y <= 3'b000;
		else begin
			case (y)
				3'b000: y <= (x == 1) ? 3'b001 : 3'b000;
				3'b001: y <= (x == 1) ? 3'b100 : 3'b001;
				3'b010: y <= (x == 1) ? 3'b001 : 3'b001; // Modified next-state for y = 010
				3'b011: y <= (x == 1) ? 3'b010 : 3'b010; // Modified next-state for y = 011
				3'b100: y <= (x == 1) ? 3'b100 : 3'b011;
				default: y <= 3'b000;
			endcase
		end
	end
	
	assign z = (y == 3'b100) || (y == 3'b011) ? 1'b1 : 1'b0;
	
endmodule
