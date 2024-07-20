module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// SOP output generation
wire sop_temp_1;
wire sop_temp_2;

assign sop_temp_1 = c & d;
assign sop_temp_2 = (~a & ~b & c);

assign out_sop = sop_temp_1 | sop_temp_2;

// POS output generation
wire pos_temp_0;
wire pos_temp_1;

assign pos_temp_0 = c & (~b | d) | (~a & b);
assign pos_temp_1 = c & (~a | d);

assign out_pos = (pos_temp_0 == pos_temp_1) ? pos_temp_0 : 1'bx;

endmodule
