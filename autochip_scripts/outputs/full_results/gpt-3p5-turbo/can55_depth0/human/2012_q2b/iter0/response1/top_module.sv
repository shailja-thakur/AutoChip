module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	reg Y1_reg;
	reg Y3_reg;

	always @(posedge w) begin
		case(y)
			6'b01_0000: begin // state A
				Y1_reg <= y[1];
				Y3_reg <= y[3];
			end
			
			6'b00_0001: begin // state B
				Y1_reg <= y[1];
				Y3_reg <= y[3];
			end

			6'b00_0010: begin // state C
				Y1_reg <= y[1];
				Y3_reg <= y[3];
			end

			6'b00_0100: begin // state D
				Y1_reg <= y[1];
				Y3_reg <= y[3];
			end

			6'b00_1000: begin // state E
				Y1_reg <= y[1];
				Y3_reg <= y[3];
			end

			6'b01_0000: begin // state F
				Y1_reg <= y[1];
				Y3_reg <= y[3];
			end
		endcase
	end

	assign Y1 = Y1_reg;
	assign Y3 = Y3_reg;

endmodule
