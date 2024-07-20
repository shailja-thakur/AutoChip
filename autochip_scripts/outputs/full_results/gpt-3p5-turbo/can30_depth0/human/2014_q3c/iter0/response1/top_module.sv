module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	
	always @(posedge clk) begin
		case({x, y})
			2'b00 : begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
			2'b01 : begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
			2'b10 : begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
			2'b11 : begin
				Y0 <= 1'b0;
				z <= 1'b1;
			end
			default : begin
				Y0 <= 1'b0;
				z <= 1'b0;
			end
		endcase
	end
	
endmodule
