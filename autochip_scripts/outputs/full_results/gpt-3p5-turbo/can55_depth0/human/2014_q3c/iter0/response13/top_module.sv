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
				if (x) begin
					Y0 <= 1;
				end else begin
					Y0 <= 0;
				end
				z <= 0;
			3'b001:
				if (x) begin
					Y0 <= 0;
				end else begin
					Y0 <= 1;
				end
				z <= 0;
			3'b010:
				if (x) begin
					Y0 <= 0;
				end else begin
					Y0 <= 1;
				end
				z <= 0;
			3'b011:
				if (x) begin
					Y0 <= 0;
				end else begin
					Y0 <= 1;
				end
				z <= 1;
			3'b100:
				if (x) begin
					Y0 <= 1;
				end else begin
					Y0 <= 1;
				end
				z <= 1;
		endcase
	end
endmodule
