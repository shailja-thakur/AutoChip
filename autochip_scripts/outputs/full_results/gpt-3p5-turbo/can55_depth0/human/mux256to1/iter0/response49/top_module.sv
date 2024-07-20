module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [7:0] sel_extended;
assign sel_extended = sel;

genvar i;
generate
for(i=0;i<256;i=i+1)
begin: mux_block
    assign out = (sel_extended == i) ? in[i] : out;
end
endgenerate
endmodule
