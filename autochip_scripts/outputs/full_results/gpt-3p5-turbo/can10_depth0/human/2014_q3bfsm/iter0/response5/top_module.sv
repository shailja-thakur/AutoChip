module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] y;
reg [2:0] next_y;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		y <= 3'b000;
	end else begin
		y <= next_y;
	end
end

always @(*) begin
	if (x) begin
		case (y)
			3'b000: next_y = 3'b001;
			3'b001: next_y = 3'b100;
			3'b010: next_y = 3'b001;
			3'b011: next_y = 3'b010;
			3'b100: next_y = 3'b100;
			default: next_y = 3'b000;
		endcase
	else begin
		case (y)
			3'b000: next_y = 3'b000;
			3'b001: next_y = 3'b001;
			3'b010: next_y = 3'b010;
			3'b011: next_y = 3'b001;
			3'b100: next_y = 3'b011;
			default: next_y = 3'b000;
		endcase
	end
end

always @(posedge clk) begin
	if (y == 3'b011 || y == 3'b100) begin
		z <= 1;
	else begin
		z <= 0;
	end
end

endmodule
