module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	reg out_sop;
	always @(a or b or c or d)
	begin
		case ({a, b, c, d})
			4'b0000: out_sop <= 1'b0;
			4'b0001: out_sop <= 1'b0;
			4'b0010: out_sop <= 1'b1;
			4'b0011: out_sop <= 1'b0;
			4'b0100: out_sop <= 1'b0;
			4'b0101: out_sop <= 1'b0;
			4'b0110: out_sop <= 1'b0;
			4'b0111: out_sop <= 1'b1;
			4'b1000: out_sop <= 1'b0;
			4'b1001: out_sop <= 1'b1;
			4'b1010: out_sop <= 1'b0;
			4'b1011: out_sop <= 1'b0;
			4'b1100: out_sop <= 1'b0;
			4'b1101: out_sop <= 1'b1;
			4'b1110: out_sop <= 1'b1;
			4'b1111: out_sop <= 1'b0;
		endcase
	end

	reg out_pos;
	always @(a or b or c or d)
	begin
		case ({a, b, c, d})
			4'b0000: out_pos <= 1'b1;
			4'b0001: out_pos <= 1'b1;
			4'b0010: out_pos <= 1'b0;
			4'b0011: out_pos <= 1'b1;
			4'b0100: out_pos <= 1'b1;
			4'b0101: out_pos <= 1'b1;
			4'b0110: out_pos <= 1'b1;
			4'b0111: out_pos <= 1'b0;
			4'b1000: out_pos <= 1'b1;
			4'b1001: out_pos <= 1'b0;
			4'b1010: out_pos <= 1'b1;
			4'b1011: out_pos <= 1'b1;
			4'b1100: out_pos <= 1'b1;
			4'b1101: out_pos <= 1'b0;
			4'b1110: out_pos <= 1'b0;
			4'b1111: out_pos <= 1'b1;
		endcase
	end
endmodule
