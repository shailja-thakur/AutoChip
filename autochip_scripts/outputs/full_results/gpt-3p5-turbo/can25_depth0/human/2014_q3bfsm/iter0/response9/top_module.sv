module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] y_reg, y_next;

	always @(posedge clk, posedge reset)
	begin
		if (reset)
			y_reg <= 3'b000;
		else
			y_reg <= y_next;
	end

	always @*
	begin
		case (y_reg)
			3'b000:
				begin
					if (x == 1'b0)
						y_next = 3'b000;
					else
						y_next = 3'b001;
					z = 1'b0;
				end
			3'b001:
				begin
					if (x == 1'b0)
						y_next = 3'b001;
					else
						y_next = 3'b100;
					z = 1'b0;
				end
			3'b010:
				begin
					if (x == 1'b0)
						y_next = 3'b010;
					else
						y_next = 3'b001;
					z = 1'b0;
				end
			3'b011:
				begin
					if (x == 1'b0)
						y_next = 3'b001;
					else
						y_next = 3'b010;
					z = 1'b1;
				end
			3'b100:
				begin
					if (x == 1'b0)
						y_next = 3'b011;
					else
						y_next = 3'b100;
					z = 1'b1;
				end
		endcase
	end
endmodule
