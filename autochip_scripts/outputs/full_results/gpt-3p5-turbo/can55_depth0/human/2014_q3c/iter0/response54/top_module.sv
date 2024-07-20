module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	reg [2:0] Y;

	always @(posedge clk) begin
		case (y)
			3'b000:
				if (x == 1) begin
					Y <= 3'b001;
					Y0 <= Y[0];
				end else begin
					Y <= 3'b000;
					Y0 <= Y[0];
				end
				z <= 1'b0;
			
			3'b001:
				if (x == 1) begin
					Y <= 3'b100;
					Y0 <= Y[0];
				end else begin
					Y <= 3'b001;
					Y0 <= Y[0];
				end
				z <= 1'b0;
			
			3'b010:
				if (x == 1) begin
					Y <= 3'b001;
					Y0 <= Y[0];
				end else begin
					Y <= 3'b010;
					Y0 <= Y[0];
				end
				z <= 1'b0;
			
			3'b011:
				if (x == 1) begin
					Y <= 3'b010;
					Y0 <= Y[0];
				end else begin
					Y <= 3'b001;
					Y0 <= Y[0];
				end
				z <= 1'b1;
			
			3'b100:
				if (x == 1) begin
					Y <= 3'b100;
					Y0 <= Y[0];
				end else begin
					Y <= 3'b011;
					Y0 <= Y[0];
				end
				z <= 1'b1;
		endcase
	end
endmodule
