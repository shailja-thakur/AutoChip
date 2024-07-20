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
				3'b000: if (x) y <= 3'b001; else y <= 3'b000;
				3'b001: if (x) y <= 3'b100; else y <= 3'b001;
				3'b010: if (x) y <= 3'b001; else y <= 3'b010;
				3'b011: if (x) y <= 3'b010; else y <= 3'b001;
				3'b100: if (x) y <= 3'b100; else y <= 3'b011;
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (y)
			3'b011: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end
	
endmodule
