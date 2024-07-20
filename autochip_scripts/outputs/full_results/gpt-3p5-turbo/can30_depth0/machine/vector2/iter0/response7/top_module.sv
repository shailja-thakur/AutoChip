module top_module (
  input [31:0] in,
  output [31:0] out
);

  reg [7:0] chunk0;
  reg [7:0] chunk1;
  reg [7:0] chunk2;
  reg [7:0] chunk3;

  always @* begin
    chunk0 = in[7:0];
    chunk1 = in[15:8];
    chunk2 = in[23:16];
    chunk3 = in[31:24];

    out = {chunk3, chunk2, chunk1, chunk0};
  end

endmodule
