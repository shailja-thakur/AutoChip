module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] y_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			y_next <= 3'b000;
		end else begin
			case (y_next)
				3'b000: begin
					if (x)
						y_next <= 3'b001;
					else
						y_next <= 3'b000;
				end
				3'b001: begin
					if (x)
						y_next <= 3'b100;
					else
						y_next <= 3'b001;
				end
				3'b010: begin
					if (x)
						y_next <= 3'b001;
					else
						y_next <= 3'b010;
				end
				3'b011: begin
					if (x)
						y_next <= 3'b010;
					else
						y_next <= 3'b001;
				end
				3'b100: begin
					if (x)
						y_next <= 3'b100;
					else
						y_next <= 3'b011;
				end
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			z <= 1'b0;
		end else begin
			case (y_next)
				3'b011, 3'b100: z <= 1'b1;
				default: z <= 1'b0;
			endcase
		end
	end

endmodule
