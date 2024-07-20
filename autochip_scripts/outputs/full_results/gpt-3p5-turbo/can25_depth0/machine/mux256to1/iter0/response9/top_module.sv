module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

reg [7:0] address;
reg out;

always @(*) begin
	address = sel;
	out = in[address];
end

endmodule
