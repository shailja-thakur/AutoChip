module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);

wire [3:0] in_sel [255:0];

genvar i;
generate
	for (i = 0; i < 256; i = i + 1) begin: MUX_GEN
		assign in_sel[i] = in[i*4 +: 4];
	end
endgenerate

always @(*) begin
	case (sel)
		0: out = in_sel[0];
		1: out = in_sel[1];
		2: out = in_sel[2];
		3: out = in_sel[3];
		4: out = in_sel[4];
		5: out = in_sel[5];
		6: out = in_sel[6];
		7: out = in_sel[7];
		default: out = in_sel[0];
	endcase
end

endmodule
