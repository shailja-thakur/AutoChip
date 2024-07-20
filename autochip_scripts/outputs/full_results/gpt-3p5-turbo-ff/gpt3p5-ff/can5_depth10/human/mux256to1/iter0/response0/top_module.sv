module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [255:0] temp;

always @ (sel)
begin
    temp = in[sel*32 +: 32];
    out = temp[31];
end

endmodule
