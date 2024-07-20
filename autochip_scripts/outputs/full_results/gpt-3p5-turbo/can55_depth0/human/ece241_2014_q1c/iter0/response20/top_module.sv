module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  reg [8:0] temp_s;
  reg temp_overflow;

  always @* begin
    temp_s = a + b;
    temp_overflow = ((a[7] ^ b[7]) & (s[7] ^ a[7]));
  end

  assign s = temp_s[7:0];
  assign overflow = temp_overflow;

endmodule
