module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
  
  reg [98:0] out_both_reg;
  reg [99:1] out_any_reg;
  reg [99:0] out_different_reg;
  
  always @* begin
    // out_both
    out_both_reg[0] = in[0] & in[99];
    for (int i=1; i<99; i=i+1) begin
      out_both_reg[i] = in[i] & in[i-1];
    end
    
    // out_any
    out_any_reg[99] = in[98] | in[99];
    for (int i=98; i>=1; i=i-1) begin
      out_any_reg[i] = in[i-1] | in[i];
    end
    
    // out_different
    out_different_reg[0] = (in[0] != in[99]);
    for (int i=1; i<100; i=i+1) begin
      out_different_reg[i] = (in[i] != in[i-1]);
    end
  end
  
  assign out_both = out_both_reg;
  assign out_any = out_any_reg;
  assign out_different = out_different_reg;

endmodule
