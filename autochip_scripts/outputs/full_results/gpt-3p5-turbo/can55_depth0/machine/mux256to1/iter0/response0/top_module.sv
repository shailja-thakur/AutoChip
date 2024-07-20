module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

reg [7:0] index;

always @ (*) begin
    index = sel;
end

assign out = in[index];

endmodule
