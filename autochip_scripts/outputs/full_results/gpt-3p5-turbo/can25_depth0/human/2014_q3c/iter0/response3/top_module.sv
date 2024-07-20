module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

always @(posedge clk) begin
	case(y)
		3'b000: begin
			if(x == 0)
				Y0 <= 0;
			else
				Y0 <= 0;
		end
		3'b001: begin
			if(x == 0)
				Y0 <= 0;
			else
				Y0 <= 1;
		end
		3'b010: begin
			if(x == 0)
				Y0 <= 0;
			else
				Y0 <= 0;
		end
		3'b011: begin
			if(x == 0)
				Y0 <= 1;
			else
				Y0 <= 0;
		end
		3'b100: begin
			if(x == 0)
				Y0 <= 0;
			else
				Y0 <= 1;
		end
	endcase
	
	if(Y0 == 0)
		z <= 0;
	else
		z <= 1;
end

endmodule
