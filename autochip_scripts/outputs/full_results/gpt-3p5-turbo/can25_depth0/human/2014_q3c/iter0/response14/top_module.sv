module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	always @(posedge clk) begin
		case (y)
			3'b000:
				if (x)
					Y0 <= 1'b0;
				else
					Y0 <= 1'b0;
				z <= 1'b0;
			3'b001:
				if (x)
					Y0 <= 1'b0;
				else
					Y0 <= 1'b1;
				z <= 1'b0;
			3'b010:
				if (x)
					Y0 <= 1'b0;
				else
					Y0 <= 1'b0;
				z <= 1'b0;
			3'b011:
				if (x)
					Y0 <= 1'b0;
				else
					Y0 <= 1'b1;
				z <= 1'b1;
			3'b100:
				if (x)
					Y0 <= 1'b1;
				else
					Y0 <= 1'b1;
				z <= 1'b1;
		endcase
	end
endmodule
