module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

	reg Y1_inst;
	reg Y3_inst;

	always @(y, w) begin
		case (y)
			6'b000001: begin
				Y1_inst <= w;
				Y3_inst <= 1'b0;
			end
			6'b000010: begin
				Y1_inst <= w;
				Y3_inst <= 1'b0;
			end
			6'b000100: begin
				Y1_inst <= w;
				Y3_inst <= 1'b0;
			end
			6'b001000: begin
				Y1_inst <= w;
				Y3_inst <= 1'b0;
			end
			6'b010000: begin
				Y1_inst <= w;
				Y3_inst <= 1'b1;
			end
			6'b100000: begin
				Y1_inst <= w;
				Y3_inst <= 1'b0;
			end
			default: begin
				Y1_inst <= 1'b0;
				Y3_inst <= 1'b0;
			end
		endcase
	end

	assign Y1 = Y1_inst;
	assign Y3 = Y3_inst;

endmodule
