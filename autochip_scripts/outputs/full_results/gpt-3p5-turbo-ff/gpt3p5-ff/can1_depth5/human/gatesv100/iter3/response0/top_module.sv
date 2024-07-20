module top_module (
  input [99:0] in,
  output reg [98:0] out_both,
  output reg [99:0] out_any,
  output reg [99:0] out_different
);

  // Calculate out_both
  always @* begin
    out_both[0] = in[0] & in[99];    // Wrap around for the leftmost bit
    for (int i = 1; i < 99; i++) begin
      out_both[i] = in[i] & in[i-1];
    end
  end

  // Calculate out_any
  always @* begin
    out_any[0] = in[0] | in[1];
    for (int i = 1; i < 99; i++) begin
      out_any[i] = in[i] | in[i+1];
    end
    out_any[99] = in[99];    // Wrap around for the rightmost bit
  end

  // Calculate out_different
  always @* begin
    out_different[0] = in[0] != in[99];    // Wrap around for the leftmost bit
    for (int i = 1; i < 99; i++) begin
      out_different[i] = in[i] != in[i-1];
    end
    out_different[99] = in[99] != in[0];   // Wrap around for the rightmost bit
  end

  // Padding for out_any
  assign out_any[100] = 1'b0;
  
endmodule
