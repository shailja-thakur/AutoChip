module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] selected_in;
genvar i;
generate
    for (i=0; i<256; i=i+1) begin
        assign selected_in[i] = in[i*4+sel+1:i*4+sel];
    end
endgenerate

mux4to1 mux (
	.in0(selected_in[0]),
	.in1(selected_in[1]),
	.in2(selected_in[2]),
	.in3(selected_in[3]),
	.sel(sel[1:0]),
	.out(out)
);

endmodule
module mux4to1 (
	input [3:0] in0,
	input [3:0] in1,
	input [3:0] in2,
	input [3:0] in3,
	input [1:0] sel,
	output [3:0] out
);
	
wire [3:0] temp1, temp2;

assign temp1 = (sel[1] == 0) ? in0 : in1;
assign temp2 = (sel[0] == 0) ? in2 : in3;

assign out = (sel == 2'b00) ? temp1 : temp2;

endmodule
