module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg [2:0] Y,
	output reg Y0,
	output reg z
);

always @(posedge clk or posedge x) begin
	if (x == 0) begin
		case(y)
			3'b000:
				Y <= 3'b000;
				Y0 <= Y[0];
				z <= 0;
			3'b001:
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 0;
			3'b010:
				Y <= 3'b010;
				Y0 <= Y[0];
				z <= 0;
			3'b011:
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 0;
			3'b100:
				Y <= 3'b011;
				Y0 <= Y[0];
				z <= 1;
		endcase
	end else begin
		case(y)
			3'b000:
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 0;
			3'b001:
				Y <= 3'b100;
				Y0 <= Y[0];
				z <= 0;
			3'b010:
				Y <= 3'b001;
				Y0 <= Y[0];
				z <= 0;
			3'b011:
				Y <= 3'b010;
				Y0 <= Y[0];
				z <= 1;
			3'b100:
				Y <= 3'b100;
				Y0 <= Y[0];
				z <= 1;
		endcase
	end
end

endmodule
