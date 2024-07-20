module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  reg [98:0] both;
  reg [99:1] any;
  reg [99:0] different;
  
  always @* begin
    // Calculate out_both
    for (int i = 0; i < 99; i=i+1) begin
      if (in[i] && in[i+1])
        both[i] = 1;
      else
        both[i] = 0;
    end
    
    // Calculate out_any
    any[99] = in[98];
    for (int i = 98; i > 1; i=i-1) begin
      if (in[i] || in[i-1])
        any[i] = 1;
      else
        any[i] = 0;
    end
    
    // Calculate out_different
    for (int i = 0; i < 99; i=i+1) begin
      if (in[i] != in[(i+99) % 100])
        different[i] = 1;
      else
        different[i] = 0;
    end
    different[99] = in[99] != in[0];
  end

  assign out_both = both;
  assign out_any = any;
  assign out_different = different;
  
endmodule
