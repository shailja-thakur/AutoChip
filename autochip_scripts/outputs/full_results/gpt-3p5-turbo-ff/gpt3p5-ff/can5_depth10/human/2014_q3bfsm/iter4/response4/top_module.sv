module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] y, next_y;
	reg [2:0] next_y_x0, next_y_x1;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			y <= 3'b000;
		else
			y <= next_y;
	end
	
	always @(y or x) begin
		case (y)
			3'b000: begin
				next_y_x0 = 3'b000;
				next_y_x1 = 3'b001;
				z = 1'b0;
			end
			
			3'b001: begin
				next_y_x0 = 3'b001;
				next_y_x1 = 3'b100;
				z = 1'b0;
			end
			
			3'b010: begin
				next_y_x0 = 3'b010;
				next_y_x1 = 3'b001;
				z = 1'b0;
			end
			
			3'b011: begin
				next_y_x0 = 3'b001;
				next_y_x1 = 3'b010;
				z = 1'b1;
			end
			
			3'b100: begin
				next_y_x0 = 3'b011;
				next_y_x1 = 3'b100;
				z = 1'b1;
			end
		endcase
		
		if (x)
			next_y = next_y_x1;
		else
			next_y = next_y_x0;
	end
	
endmodule
