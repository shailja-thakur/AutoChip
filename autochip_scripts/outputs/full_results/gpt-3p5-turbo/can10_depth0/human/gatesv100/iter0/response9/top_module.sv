module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  reg [98:0] temp_both;
  reg [99:2] temp_any;
  reg [99:0] temp_different;

  // out_both
  always @* begin
    for (int i = 0; i < 99; i = i + 1)
      temp_both[i] = (in[i] && in[i+1]);
  end

  assign out_both = temp_both;

  // out_any
  always @* begin
    for (int i = 1; i < 100; i = i + 1)
      temp_any[i] = (in[i] || in[i-1]);
  end

  assign out_any = temp_any;

  // out_different
  always @* begin
    temp_different[99] = (in[99] != in[0]);
    for (int i = 0; i < 99; i = i + 1)
      temp_different[i] = (in[i] != in[i+1]);
  end

  assign out_different = temp_different;

endmodule
