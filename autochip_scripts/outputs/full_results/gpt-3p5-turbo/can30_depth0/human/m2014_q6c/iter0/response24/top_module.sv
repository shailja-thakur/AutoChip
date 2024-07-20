module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg Y2_reg;
reg Y4_reg;

always @(y or w)
begin
	case (y)
	6'b000001: begin
		Y2_reg = 1'b0;
		Y4_reg = w;
	end
	6'b000010: begin
		Y2_reg = 1'b1;
		Y4_reg = ~w;
	end
	6'b000100: begin
		Y2_reg = 1'b0;
		Y4_reg = w;
	end
	6'b001000: begin
		Y2_reg = 1'b0;
		Y4_reg = ~w;
	end
	6'b010000: begin
		Y2_reg = 1'b0;
		Y4_reg = w;
	end
	6'b100000: begin
		Y2_reg = 1'b0;
		Y4_reg = w;
	end
	default: begin
		Y2_reg = 1'b0;
		Y4_reg = 1'b0;
	end
	endcase
end

assign Y2 = Y2_reg;
assign Y4 = Y4_reg;

endmodule
