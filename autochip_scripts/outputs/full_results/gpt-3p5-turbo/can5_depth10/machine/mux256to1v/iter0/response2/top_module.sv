module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [1023:0] in_reg;
reg [3:0] out_reg;

always @(*) begin
  in_reg = in;
  out_reg = in_reg[sel*4 +: 4];
end

assign out = out_reg;

endmodule
