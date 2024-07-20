module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] selected;
assign out = in[selected];

always @ (*)
begin
	selected = sel;
end

endmodule
