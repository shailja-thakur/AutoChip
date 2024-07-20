module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] sel_extended;
reg [0:255] sel_masked;
wire [7:0] sel_1hot;
reg out_reg;

assign sel_1hot[sel] = 1'b1;
assign sel_extended = {8{sel_1hot[7]}};
assign sel_masked = sel_extended & in;

always @* begin
    out_reg = sel_masked;
end

assign out = out_reg;

endmodule
