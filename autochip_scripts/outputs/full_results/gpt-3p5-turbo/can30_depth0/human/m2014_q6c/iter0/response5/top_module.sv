module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg Y2;
reg Y4;

always @(y or w) begin
	case(y)
		6'b000001: begin		// state A
			Y2 = 1'b1;
			Y4 = 1'b0;
		end
		6'b000010: begin		// state B
			Y2 = 1'b0;
			Y4 = 1'b1;
		end
		6'b000100: begin		// state C
			Y2 = 1'b1;
			Y4 = 1'b1;
		end
		6'b001000: begin		// state D
			Y2 = 1'b1;
			Y4 = 1'b0;
		end
		6'b010000: begin		// state E
			Y2 = 1'b0;
			Y4 = 1'b0;
		end
		6'b100000: begin		// state F
			Y2 = 1'b0;
			Y4 = 1'b1;
		end
		default: begin		// default case
			Y2 = 1'b0;
			Y4 = 1'b0;
		end
	endcase
end

endmodule
