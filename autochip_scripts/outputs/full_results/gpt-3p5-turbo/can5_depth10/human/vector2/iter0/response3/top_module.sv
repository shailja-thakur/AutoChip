module top_module (
	input [31:0] in,
	output [31:0] out
);

  reg [7:0] byte0, byte1, byte2, byte3;

  always @* begin
    byte0 = in[7:0];
    byte1 = in[15:8];
    byte2 = in[23:16];
    byte3 = in[31:24];
    out = {byte3, byte2, byte1, byte0};
  end

endmodule
