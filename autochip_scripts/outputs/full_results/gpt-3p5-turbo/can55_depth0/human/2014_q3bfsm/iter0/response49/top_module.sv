module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] y, next_y;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		y <= 3'b000;
	end else begin
		y <= next_y;
	end
end

always @(y, x) begin
	case (y)
		3'b000:
			if (x) begin
				next_y = 3'b001;
			end else begin
				next_y = 3'b000;
			end
		3'b001:
			if (x) begin
				next_y = 3'b100;
			end else begin
				next_y = 3'b001;
			end
		3'b010:
			if (x) begin
				next_y = 3'b001;
			end else begin
				next_y = 3'b010;
			end
		3'b011:
			if (x) begin
				next_y = 3'b010;
				z = 1'b1;
			end else begin
				next_y = 3'b001;
				z = 1'b0;
			end
		3'b100:
			if (x) begin
				next_y = 3'b100;
				z = 1'b1;
			end else begin
				next_y = 3'b011;
				z = 1'b0;
			end
	endcase
end

endmodule
