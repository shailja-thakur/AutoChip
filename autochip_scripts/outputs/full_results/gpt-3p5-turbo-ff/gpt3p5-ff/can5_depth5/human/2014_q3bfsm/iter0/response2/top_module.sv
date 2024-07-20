module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] y, next_y;

always @(posedge clk or posedge reset) begin
	if (reset)
		y <= 3'b000;
	else
		y <= next_y;
end

always @(y or x) begin
	case (y)
		3'b000:
			if (x)
				next_y = 3'b001;
			else
				next_y = 3'b000;
		3'b001:
			if (x)
				next_y = 3'b100;
			else
				next_y = 3'b001;
		3'b010:
			if (x)
				next_y = 3'b001;
			else
				next_y = 3'b010;
		3'b011:
			if (x)
				next_y = 3'b010;
			else
				next_y = 3'b001;
		3'b100:
			if (x)
				next_y = 3'b100;
			else
				next_y = 3'b011;
	endcase
	
	if (y == 3'b011)
		z = 1'b1;
	else
		z = 1'b0;
end

endmodule
