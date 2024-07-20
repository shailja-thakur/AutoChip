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
			if (x == 1'b0) begin
				Y <= 3'b000;
			end else begin
				Y <= 3'b001;
			end
		3'b001:
			if (x == 1'b0) begin
				Y <= 3'b001;
			end else begin
				Y <= 3'b100;
			end
		3'b010:
			if (x == 1'b0) begin
				Y <= 3'b010;
			end else begin
				Y <= 3'b001;
			end
		3'b011:
			if (x == 1'b0) begin
				Y <= 3'b001;
			end else begin
				Y <= 3'b010;
			end
		3'b100:
			if (x == 1'b0) begin
				Y <= 3'b011;
			end else begin
				Y <= 3'b100;
			end
	endcase
end

always @(posedge clk) begin
	if (Y[0] == 1'b1) begin
		z <= 1'b1;
	end else begin
		z <= 1'b0;
	end
end

assign Y0 = Y[0];

endmodule
